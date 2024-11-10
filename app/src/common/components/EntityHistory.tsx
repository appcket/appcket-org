import { ReactNode } from 'react';
import PropTypes from 'prop-types';
import Grid from '@mui/material/Grid2';
import Timeline from '@mui/lab/Timeline';
import TimelineItem from '@mui/lab/TimelineItem';
import TimelineSeparator from '@mui/lab/TimelineSeparator';
import TimelineConnector from '@mui/lab/TimelineConnector';
import TimelineContent from '@mui/lab/TimelineContent';
import TimelineDot from '@mui/lab/TimelineDot';
import TimelineOppositeContent, {
  timelineOppositeContentClasses,
} from '@mui/lab/TimelineOppositeContent';
import Typography from '@mui/material/Typography';
import Accordion from '@mui/material/Accordion';
import AccordionSummary from '@mui/material/AccordionSummary';
import AccordionDetails from '@mui/material/AccordionDetails';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import { isNull } from 'lodash';
import { JsonViewer } from '@textea/json-viewer';

import Loading from 'src/common/components/Loading';
import DateTime from 'src/common/components/DateTime';
import { useGetEntityHistory } from 'src/common/api/entityHistory';
import { IEntityHistoryChange } from 'src/common/models/EntityHistory';
import Resources from 'src/common/enums/resources.enum';
import { isJson } from 'src/common/utils/general';

type Props = {
  entityId: string;
  entityType: Resources;
};

const displayText = (change: IEntityHistoryChange, entityType: Resources): ReactNode => {
  if (isNull(change.fieldName)) {
    if (isNull(change.oldValue)) {
      let newValue = JSON.parse(change.newValue);
      return (
        <div>
          <Typography variant="body2">{change.changedBy.displayName}</Typography>
          <Typography variant="subtitle2">created</Typography>
          <Typography variant="body1">a new {entityType}:</Typography>
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
          <Typography variant="subtitle2">deleted</Typography>
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
        <Typography variant="subtitle2">changed</Typography>
        <Typography variant="body1">{change.fieldName}</Typography>
        <Typography variant="subtitle2">from</Typography>
        {renderOldValue}
        <Typography variant="subtitle2">to</Typography>
        {renderNewValue}
      </div>
    );
  }
};

const EntityHistory = ({ entityId, entityType }: Props) => {
  const { status, data, error, isFetching } = useGetEntityHistory(entityId, entityType);

  let content;

  if (isFetching) {
    content = <Loading />;
  } else if (status === 'error' && error instanceof Error) {
    content = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    if (data?.changes?.length === 0) {
      content = <Typography variant="subtitle2">No history yet</Typography>;
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
                <DateTime dateTimeString={change.changedAt} />
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
            <Typography>History</Typography>
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
