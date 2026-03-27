import { useQueryClient } from '@tanstack/react-query';
import { notifications } from '@mantine/notifications';
import { useTopic, EventEnvelope } from 'src/hooks/useTopic';
import { Resources } from 'src/hooks/useHistory';
import { HiOutlineInformationCircle } from 'react-icons/hi2';
import * as m from 'src/paraglide/messages';

/**
 * A headless component that listens for global events from the WebSocket stream
 * and triggers appropriate side effects (cache invalidation, notifications, etc).
 */
export function GlobalEventHandler() {
  const queryClient = useQueryClient();

  useTopic('events', (envelope: EventEnvelope) => {
    console.log('[GlobalEventHandler] Received event:', envelope);

    // 1. Handle Cache Invalidation
    switch (envelope.resource) {
      case Resources.Team:
        console.log('🔄 Invalidating Teams queries');
        queryClient.invalidateQueries({ queryKey: ['searchTeams'] });
        queryClient.invalidateQueries({ queryKey: ['getTeam'] });
        queryClient.invalidateQueries({ queryKey: ['getEntityHistory', envelope.id] });
        break;

      case Resources.Project:
        console.log('🔄 Invalidating Projects queries');
        queryClient.invalidateQueries({ queryKey: ['searchProjects'] });
        queryClient.invalidateQueries({ queryKey: ['getProject'] });
        queryClient.invalidateQueries({ queryKey: ['getEntityHistory', envelope.id] });
        break;

      case Resources.Task:
        console.log('🔄 Invalidating Tasks queries');
        queryClient.invalidateQueries({ queryKey: ['searchTasks'] });
        queryClient.invalidateQueries({ queryKey: ['getTask'] });
        queryClient.invalidateQueries({ queryKey: ['getEntityHistory', envelope.id] });
        break;

      default:
        console.log(`⚠️ Unhandled resource type: ${envelope.resource}`);
        break;
    }

    // 2. Optional: Show Notification for external updates
    notifications.show({
      title: m.messages_info_realtime_update_title(),
      message: m.messages_info_realtime_update_message({
        resource: envelope.resource,
        action: envelope.action,
      }),
      icon: <HiOutlineInformationCircle />,
      color: 'blue',
      autoClose: 3000,
    });
  });

  return null; // Headless component
}
