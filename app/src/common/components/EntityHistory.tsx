import { ReactNode } from 'react';
import PropTypes from 'prop-types';
import Grid from '@mui/material/Grid2';
import Typography from '@mui/material/Typography';
import Timeline from '@mui/lab/Timeline';
import TimelineItem from '@mui/lab/TimelineItem';
import TimelineSeparator from '@mui/lab/TimelineSeparator';
import TimelineConnector from '@mui/lab/TimelineConnector';
import TimelineContent from '@mui/lab/TimelineContent';
import TimelineDot from '@mui/lab/TimelineDot';
import TimelineOppositeContent, {
  timelineOppositeContentClasses,
} from '@mui/lab/TimelineOppositeContent';
import Accordion from '@mui/material/Accordion';
import AccordionSummary from '@mui/material/AccordionSummary';
import AccordionDetails from '@mui/material/AccordionDetails';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import History from '@mui/icons-material/History';
import { isNull } from 'lodash';
import { JsonViewer } from '@textea/json-viewer';
import { useTranslation } from 'react-i18next';

import Loading from 'src/common/components/Loading';
import { useGetEntityHistory } from 'src/common/api/entityHistory';
import { IEntityHistoryChange } from 'src/common/models/EntityHistory';
import Resources from 'src/common/enums/Resources';
import QueryStatuses from 'src/common/enums/QueryStatuses';
import { isJson } from 'src/common/utils/general';

type Props = {
  entityId: string;
  entityType: Resources;
};

const EntityHistory = ({ entityId, entityType }: Props) => {
  const { t } = useTranslation();
  const { status, data, error, isFetching } = useGetEntityHistory(entityId, entityType);

  const displayText = (change: IEntityHistoryChange, entityType: Resources): ReactNode => {
    if (isNull(change.fieldName)) {
      if (isNull(change.oldValue)) {
        let newValue = JSON.parse(change.newValue);
        return (
          <div>
            <Typography variant="body2">{change.changedBy.displayName}</Typography>
            <Typography variant="subtitle2">{t('common.created').toLowerCase()}</Typography>
            <Typography variant="body1">
              a new {t('entities.' + entityType.toLowerCase())}:
            </Typography>
            <JsonViewer
              sx={{ backgroundColor: '#d9d9d9' }}
              value={newValue}
              displayDataTypes={false}
              displaySize={false}
              enableClipboard={false}
            />
          </div>
        );
      } else {
        return (
          <div>
            <Typography variant="body2">{change.changedBy.displayName}</Typography>
            <Typography variant="subtitle2">{t('common.deleted').toLowerCase()}</Typography>
            <Typography variant="body1">an {entityType}:</Typography>
            <Typography variant="body1">{change.oldValue}</Typography>
          </div>
        );
      }
    } else {
      let newValue = change.newValue;
      let oldValue = change.oldValue;
      let renderNewValue = <Typography variant="body1">{newValue}</Typography>;
      let renderOldValue = <Typography variant="body1">{oldValue}</Typography>;
      if (isJson(newValue)) {
        newValue = JSON.parse(change.newValue);
        renderNewValue = (
          <JsonViewer
            sx={{ backgroundColor: '#d9d9d9' }}
            value={newValue}
            displayDataTypes={false}
            displaySize={false}
            enableClipboard={false}
          />
        );
      }
      if (isJson(oldValue)) {
        oldValue = JSON.parse(change.oldValue);
        renderOldValue = (
          <JsonViewer
            sx={{ backgroundColor: '#d9d9d9' }}
            value={oldValue}
            displayDataTypes={false}
            displaySize={false}
            enableClipboard={false}
          />
        );
      }

      return (
        <div>
          <Typography variant="body2">{change.changedBy.displayName}</Typography>
          <Typography variant="subtitle2">{t('common.updated').toLowerCase()}</Typography>
          <Typography variant="body1">{change.fieldName}</Typography>
          <Typography variant="subtitle2">{t('common.from')}</Typography>
          {renderOldValue}
          <Typography variant="subtitle2">{t('common.to')}</Typography>
          {renderNewValue}
        </div>
      );
    }
  };

  let content;

  if (isFetching) {
    content = <Loading />;
  } else if (status === QueryStatuses.Error && error instanceof Error) {
    content = (
      <Typography component="p">
        {t('messages.error.error')}: {error.message}
      </Typography>
    );
  } else {
    if (data?.changes?.length === 0) {
      content = <Typography variant="subtitle2">{t('messages.info.noHistory')}</Typography>;
    } else {
      content = (
        <Timeline
          sx={{
            [`& .${timelineOppositeContentClasses.root}`]: {
              flex: 0.15,
            },
          }}
        >
          {data?.changes?.map((change: IEntityHistoryChange, index: number) => (
            <TimelineItem key={index}>
              <TimelineOppositeContent color="textSecondary">
                {t('common.dateTime', { value: change.changedAt })}
              </TimelineOppositeContent>
              <TimelineSeparator>
                <TimelineDot />
                <TimelineConnector />
              </TimelineSeparator>
              <TimelineContent>{displayText(change, entityType)}</TimelineContent>
            </TimelineItem>
          ))}
        </Timeline>
      );
    }
  }

  let component = (
    <Grid container spacing={2}>
      <Grid size={{ xs: 12 }}>
        <Accordion>
          <AccordionSummary
            expandIcon={<ExpandMoreIcon />}
            aria-controls="history-content"
            id="history-header"
          >
            <div className="flex items-center">
              <History />
              <Typography sx={{ ml: 1 }}>{t('common.history')}</Typography>
            </div>
          </AccordionSummary>
          <AccordionDetails>{content}</AccordionDetails>
        </Accordion>
      </Grid>
    </Grid>
  );

  return <div>{component}</div>;
};

EntityHistory.propTypes = {
  entityId: PropTypes.string,
};

export default EntityHistory;
