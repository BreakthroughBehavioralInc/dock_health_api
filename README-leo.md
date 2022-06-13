# Dock Health API

```ruby
# Create task with task description, tasklist type and tasklist id
params = { description: "description", taskList: { type: "taskList type", id: "<taskList ID>" } }
DockHealthApi::Task.create(params)

# Show all tasks (Must supply at least 1 of 'taskListIdentifier', 'patientIdentifier', 'assignedToUserIdentifier', or 'criteria'.)
DockHealthApi::Task.list(taskListIdentifier: "<taskList ID>")

# Retrieve task
DockHealthApi::Task.get("<task ID>")

# Update task
params = { description: "task description", id: "<task ID>" }
DockHealthApi::Task.update(params)

# Delete task
DockHealthApi::Task.delete(id: "<task ID>")
```

```ruby
# Create tasklist with tasklist name
DockHealthApi::TaskList.create(listName: "tasklist name")

# Show all tasklists
DockHealthApi::TaskList.list

# Retrive tasklist
DockHealthApi::TaskList.get("<tasklist ID>")

# Update taskList
params = { listName: "tasklist name", id: "<tasklist ID>"}
DockHealthApi::TaskList.update(params)

# Delete tasklist
DockHealthApi::TaskList.delete(id: "<tasklist ID>")
```

```ruby
# Add existing user to tasklist
params = { taskList: { type: "tasklist type", id: "<tasklist id>" }, user: { type: "user type", id: "<user id>" } }
DockHealthApi::TaskList::User.put(params)

# Update role for existing user in tasklist
params = { taskList: { type: "tasklist type", id: "<tasklist id>" }, user: { type: "user type", id: "<user id>", userRole: "user role"} }
DockHealthApi::TaskList::User.update(params)

# Delete existing user from tasklist
params = { taskList: { type: "tasklist type", id: "<tasklist id>" }, user: { type: "user type", id: "<user id>" } }
DockHealthApi::TaskList::User.delete(params)
```

```ruby
# Create webhook with url, secret and events
params = { "url": "url *must start with https://*", "secret": "secret", "events": ["array of event(s)"] }
DockHealthApi::Webhook.create(params)

# Show all webhooks
DockHealthApi::Webhook.list

# Retrive webhooks
DockHealthApi::Webhook.get("<webhook ID>")

# Update webhook
params = { "url": "url *must start with https://*", "secret": "secret", "events": ["array of event(s)"], id: "<webhook ID>" }
DockHealthApi::Webhook.put(params)

# Delete webhook
DockHealthApi::Webhook.delete(id: "<webhook id>")
```

## Task Data Format

```ruby
{
  "description": "string",
  "tokenizedDescription": "string",
  "details": "string",
  "tokenizedDetails": "string",
  "priority": "HIGH",
  "status": "COMPLETE",
  "workflowStatus": {
    "type": "DEVELOPER",
    "id": "string"
  },
  "dueDate": "2019-08-24T14:15:22Z",
  "reminderType": "NONE",
  "reminderTime": "string",
  "reminderDt": "2019-08-24T14:15:22Z",
  "creator": {
    "type": "DEVELOPER",
    "id": "string"
  },
  "assignedTo": {
    "type": "DEVELOPER",
    "id": "string"
  },
  "assignedBy": {
    "type": "DEVELOPER",
    "id": "string"
  },
  "completedBy": {
    "type": "DEVELOPER",
    "id": "string"
  },
  "subTasksCount": 0,
  "subTasksCompletedCount": 0,
  "subtasks": [
    {
      "itemType": "TASK",
      "identifier": "string",
      "taskId": 0,
      "taskIdentifier": "string",
      "externalIdentifier": "string",
      "description": "string",
      "tokenizedDescription": "string",
      "details": "string",
      "tokenizedDetails": "string",
      "priority": "HIGH",
      "status": "COMPLETE",
      "workflowStatus": {
        "identifier": "string",
        "name": "string",
        "color": "string"
      },
      "dueDate": "2019-08-24T14:15:22Z",
      "reminderType": "NONE",
      "reminderTime": "string",
      "reminderDt": "2019-08-24T14:15:22Z",
      "creator": {
        "itemType": "USER",
        "id": 0,
        "identifier": "string",
        "userId": 0,
        "userIdentifier": "string",
        "firstName": "string",
        "lastName": "string",
        "userName": "string",
        "profileThumbnailPictureHash": "string",
        "userStatus": "ACTIVE",
        "initials": "string",
        "bubbleColor": "string",
        "status": "ACTIVE",
        "orgUserRole": "OWNER",
        "taskListUserRole": "OWNER",
        "name": "string"
      },
      "assignedToUsers": [
        {
          "itemType": "USER",
          "id": 0,
          "identifier": "string",
          "userStatus": "ACTIVE",
          "bubbleColor": "string",
          "initials": "string",
          "profileThumbnailPictureHash": "string",
          "name": "string"
        }
      ],
      "addedToListByUser": {
        "itemType": "USER",
        "id": 0,
        "identifier": "string",
        "userId": 0,
        "userIdentifier": "string",
        "firstName": "string",
        "lastName": "string",
        "userName": "string",
        "profileThumbnailPictureHash": "string",
        "userStatus": "ACTIVE",
        "initials": "string",
        "bubbleColor": "string",
        "status": "ACTIVE",
        "orgUserRole": "OWNER",
        "taskListUserRole": "OWNER",
        "name": "string"
      },
      "completedBy": {
        "itemType": "USER",
        "id": 0,
        "identifier": "string",
        "userId": 0,
        "userIdentifier": "string",
        "firstName": "string",
        "lastName": "string",
        "userName": "string",
        "profileThumbnailPictureHash": "string",
        "userStatus": "ACTIVE",
        "initials": "string",
        "bubbleColor": "string",
        "status": "ACTIVE",
        "orgUserRole": "OWNER",
        "taskListUserRole": "OWNER",
        "name": "string"
      },
      "comments": [
        {
          "commentId": 0,
          "commentIdentifier": "string",
          "comment": "string",
          "tokenizedComment": "string",
          "taskIdentifier": "string",
          "creator": {
            "itemType": "USER",
            "id": 0,
            "identifier": "string",
            "userId": 0,
            "userIdentifier": "string",
            "firstName": "string",
            "lastName": "string",
            "userName": "string",
            "profileThumbnailPictureHash": "string",
            "userStatus": "ACTIVE",
            "initials": "string",
            "bubbleColor": "string",
            "status": "ACTIVE",
            "orgUserRole": "OWNER",
            "taskListUserRole": "OWNER",
            "name": "string"
          },
          "dateCreated": "2019-08-24T14:15:22Z",
          "dateUpdated": "2019-08-24T14:15:22Z",
          "sortIndex": 0,
          "commentMentions": [
            {
              "identifier": "string",
              "name": "string"
            }
          ],
          "hasMentions": true
        }
      ],
      "attachments": [
        {
          "attachmentId": 0,
          "attachmentIdentifier": "string",
          "taskIdentifier": "string",
          "fileName": "string",
          "fileIdentifier": "string",
          "fileSize": 0,
          "contentType": "string",
          "creator": {
            "itemType": "USER",
            "id": 0,
            "identifier": "string",
            "userId": 0,
            "userIdentifier": "string",
            "firstName": "string",
            "lastName": "string",
            "userName": "string",
            "profileThumbnailPictureHash": "string",
            "userStatus": "ACTIVE",
            "initials": "string",
            "bubbleColor": "string",
            "status": "ACTIVE",
            "orgUserRole": "OWNER",
            "taskListUserRole": "OWNER",
            "name": "string"
          },
          "dateCreated": "2019-08-24T14:15:22Z",
          "dateUpdated": "2019-08-24T14:15:22Z"
        }
      ],
      "labels": [
        {
          "labelIdentifier": "string",
          "labelName": "string",
          "taskIdentifier": "string"
        }
      ],
      "subTasksCount": 0,
      "subTasksCompletedCount": 0,
      "completedDt": "2019-08-24T14:15:22Z",
      "createdDateTime": "2019-08-24T14:15:22Z",
      "updatedDateTime": "2019-08-24T14:15:22Z",
      "assignmentUpdatedDateTime": "2019-08-24T14:15:22Z",
      "read": true,
      "updated": true,
      "updatedComment": true,
      "updatedLabel": true,
      "updatedAttachment": true,
      "updatedDueDate": true,
      "patient": {
        "patientId": 0,
        "patientIdentifier": "string",
        "mrn": "string",
        "firstName": "string",
        "middleName": "string",
        "lastName": "string",
        "dob": "2019-08-24T14:15:22Z",
        "age": "string",
        "gender": "string",
        "fromEMR": true,
        "patientName": "string"
      },
      "type": "IN_APP",
      "taskList": {
        "taskListId": 0,
        "taskListIdentifier": "string",
        "listName": "string",
        "listDescription": "string",
        "listType": "PUBLIC"
      },
      "parentTaskId": 0,
      "parentTaskIdentifier": "string",
      "parentTask": {},
      "active": true,
      "sourceMessage": "string",
      "subTaskSortIndex": 0,
      "archivedByUser": true,
      "edited": true,
      "duplicated": true,
      "taskGroups": [
        {
          "taskGroupIdentifier": "string",
          "groupName": "string",
          "groupDescription": "string",
          "groupType": "TASKLIST",
          "taskListIdentifier": "string",
          "sortIndexOfTaskInGroup": 0
        }
      ],
      "taskMentions": [
        {
          "identifier": "string",
          "name": "string"
        }
      ],
      "hasMentions": true,
      "hasRecurringSchedule": true,
      "intentType": "STANDARD",
      "taskLinks": [
        {
          "sourceTaskIdentifier": "string",
          "targetTaskIdentifier": "string",
          "isDependent": true,
          "delayPeriod": 0,
          "delayPeriodUnit": "HOUR",
          "delayIsBusinessDays": true,
          "decisionOutcome": "string"
        }
      ],
      "dependencyTasksCount": 0,
      "dependencyTasksCompletedCount": 0,
      "taskOutcomes": [
        {
          "taskOutcomeIdentifier": "string",
          "name": "string",
          "isSelected": true,
          "selectedDateTime": "2019-08-24T14:15:22Z",
          "selectedBy": {
            "itemType": "USER",
            "id": 0,
            "identifier": "string",
            "userId": 0,
            "userIdentifier": "string",
            "firstName": "string",
            "lastName": "string",
            "userName": "string",
            "profileThumbnailPictureHash": "string",
            "userStatus": "ACTIVE",
            "initials": "string",
            "bubbleColor": "string",
            "status": "ACTIVE",
            "orgUserRole": "OWNER",
            "taskListUserRole": "OWNER",
            "name": "string"
          }
        }
      ],
      "taskTemplateIdentifier": "string",
      "taskMetaData": [
        {
          "customFieldIdentifier": "string",
          "customFieldName": "string",
          "value": "string"
        }
      ],
      "taskBundleGroup": {
        "taskGroupIdentifier": "string",
        "groupName": "string",
        "groupDescription": "string",
        "groupType": "TASKLIST",
        "taskListIdentifier": "string",
        "sortIndexOfTaskInGroup": 0
      }
    }
  ],
  "completedDt": "2019-08-24T14:15:22Z",
  "createdDateTime": "2019-08-24T14:15:22Z",
  "updatedDateTime": "2019-08-24T14:15:22Z",
  "read": true,
  "updated": true,
  "patient": {
    "type": "DEVELOPER",
    "id": "string"
  },
  "taskList": {
    "type": "DEVELOPER",
    "id": "string"
  },
  "type": "IN_APP",
  "parentTask": {
    "type": "DEVELOPER",
    "id": "string"
  },
  "sourceMessage": "string",
  "subTaskSortIndex": 0,
  "edited": true,
  "duplicated": true,
  "hasMentions": true,
  "taskMetaData": [
    {
      "customFieldIdentifier": "string",
      "customFieldName": "string",
      "value": "string"
    }
  ],
  "id": "string",
  "identifier": "string"
}

require field
{ description: "string",
  taskList: { type: "string", id: "<tasklist ID>" }
}

Update task
{ description: "string"}
  ...
  id: "<tasklist ID"
}
```
