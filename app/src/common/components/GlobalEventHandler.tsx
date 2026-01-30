import { useQueryClient } from '@tanstack/react-query';
import { useTranslation } from 'react-i18next';
import { useSnackbar } from 'notistack';

import { useTopic } from 'src/common/hooks/useTopic';
import { EventEnvelope } from 'src/common/models/eventEnvelope';
import Resources from 'src/common/enums/Resources';

/**
 * A headless component that listens for global events from the WebSocket stream
 * and triggers appropriate side effects (cache invalidation, notifications, etc).
 */
const GlobalEventHandler = () => {
  const queryClient = useQueryClient();
  const { enqueueSnackbar } = useSnackbar();
  const { t } = useTranslation();

  useTopic('events', (envelope: EventEnvelope) => {
    console.log('[GlobalEventHandler] Received event:', envelope);

    // Handle cache invalidation based on resource type
    switch (envelope.resource) {
      case Resources.Team:
        console.log('Invalidating Teams queries');
        queryClient.invalidateQueries({ queryKey: ['searchTeams'] });
        queryClient.invalidateQueries({ queryKey: ['getTeam'] });
        break;
        
      case Resources.Project:
        console.log('Invalidating Projects queries');
        queryClient.invalidateQueries({ queryKey: ['searchProjects'] });
        queryClient.invalidateQueries({ queryKey: ['getProject'] });
        break;

      case Resources.Task:
        console.log('Invalidating Tasks queries');
        queryClient.invalidateQueries({ queryKey: ['searchTasks'] });
        queryClient.invalidateQueries({ queryKey: ['getTask'] });
        break;
        
      case Resources.Organization:
        console.log('Invalidating Organization queries');
        queryClient.invalidateQueries({ queryKey: ['getOrganization'] });
        break;

      default:
        console.log(`Unhandled resource type: ${envelope.resource}`);
        break;
    }

    // Optional: Show a toast notification for updates from *other* users
    // This requires checking if the event.userId !== currentUserId (if available in envelope)
    // enqueueSnackbar(`${envelope.resource} ${envelope.action}`, { variant: 'info' });
  });

  return null; // This component renders nothing
};

export default GlobalEventHandler;
