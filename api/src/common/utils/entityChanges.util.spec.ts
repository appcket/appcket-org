import { EntityChangesUtil } from './entityChanges.util';

describe('EntityChangesUtil', () => {
  const entityChangesUtil = new EntityChangesUtil();

  const changeInitial = {
    appId: 'd1f3593d-aff4-409a-b297-961078a162c7',
    operationType: 'Create',
    entity: {
      id: '1234',
      type: 'task',
      data: {
        title: 'Investigate Typescript Starter Kits for New Project',
        description:
          "We need an easy and quick way to kickstart the new Project Bosco initiative. I think (https://appcket.org)[https://appcket.org] could give us a shortcut so we don't have to build the basic web app functionality ourselves.",
        status: 'To Do',
        assignedTo: '101',
        priority: 'Low',
        list: [{ id: 1, name: 'List item 1' }],
      },
    },
    user: {
      id: '101',
    },
    timestamp: new Date('2023-08-23 07:39:18.000'),
  };

  const changeUpdated = {
    appId: 'd1f3593d-aff4-409a-b297-961078a162c7',
    operationType: 'Update',
    entity: {
      id: '1234',
      type: 'task',
      data: {
        title: 'Implement New Project with Appcket Starter Kit',
        description:
          'I looked at many open source and commercial Typescript based boilerplates and investigated the Appcket docs. Was able to get everything running locally. Made a quick spike and the developer experience was great. I recommend moving forward and building the new app using Appcket as the base.',
        status: 'Doing',
        assignedTo: '202',
        priority: 'High',
        list: [
          { id: 1, name: 'List item 1' },
          { id: 2, name: 'List item 2' },
        ],
      },
    },
    user: {
      id: '202',
    },
    timestamp: new Date('2023-08-23 07:39:18.000'),
  };

  const changeCompleted = {
    appId: 'd1f3593d-aff4-409a-b297-961078a162c7',
    operationType: 'Update',
    entity: {
      id: '1234',
      type: 'task',
      data: {
        title: 'Successfully Launch MVP Version of Project Bosco',
        description: 'This task has been deployed and available for users at https://project.bosco',
        status: 'Done',
        assignedTo: '303',
        priority: 'High',
        list: [
          { id: 3, name: 'List item 3' },
          { id: 2, name: 'List item 2' },
        ],
      },
    },
    user: {
      id: '303',
    },
    timestamp: new Date(),
  };

  describe('root', () => {
    it('should return changes', () => {
      const changes = [
        {
          fieldName: 'title',
          oldValue: 'Investigate Typescript Starter Kits for New Project',
          newValue: 'Implement New Project with Appcket Starter Kit',
        },
        {
          fieldName: 'description',
          oldValue:
            "We need an easy and quick way to kickstart the new Project Bosco initiative. I think (https://appcket.org)[https://appcket.org] could give us a shortcut so we don't have to build the basic web app functionality ourselves.",
          newValue:
            'I looked at many open source and commercial Typescript based boilerplates and investigated the Appcket docs. Was able to get everything running locally. Made a quick spike and the developer experience was great. I recommend moving forward and building the new app using Appcket as the base.',
        },
        {
          fieldName: 'status',
          oldValue: 'To Do',
          newValue: 'Doing',
        },
        {
          fieldName: 'assignedTo',
          oldValue: '101',
          newValue: '202',
        },
        {
          fieldName: 'priority',
          oldValue: 'Low',
          newValue: 'High',
        },
        {
          fieldName: 'list',
          oldValue: [{ id: 1, name: 'List item 1' }],
          newValue: [
            { id: 1, name: 'List item 1' },
            { id: 2, name: 'List item 2' },
          ],
        },
      ];

      const changeProcessed = entityChangesUtil.getEntityChanges(
        changeInitial.entity.data,
        changeUpdated.entity.data,
      );
      expect(changeProcessed.changes).toEqual(changes);
    });
  });
});
