# Dock Health API

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/dock_health_api`. To experiment with that code, run `bin/console` for an interactive prompt.

# Documentation
https://partner-api-dev.dockhealth.app/api-docs/redoc


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dock_health_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dock_health_api

## Usage

The library needs to be configured with your account's key and secret. Set `DockHealthApi.api_key` , ` DockHealthApi.api_secret` to their values, ideally using hidden `ENV` variables:

```ruby
require 'dock_health_api'
DockHealthApi.api_key = ENV["DOCK_HEALTH_KEY"]
DockHealthApi.api_secret = ENV["DOCK_HEALTH_SECRET"]
DockHealthApi.resource_url = ENV["DOCK_HEALTH_URL"]
# Needs to be configurably set in hidden ENV variables to interact with below resources
DOCK_USER="x-user-id"
DOCK_ORG="x-organization-id"

# Acquire x-user-id and x-organization-id
DockHealthApi::Developer.list
DockHealthApi::Organization.list


# List All Patients
DockHealthApi::Patient.list
# Get Specific Patient
DockHealthApi::Patient.get('id of patient')
# Create Patient
DockHealthApi::Patient.create(patient_data)
# Update Specific Patient
DockHealthApi::Patient.update(updated_patient_data)
# Delete Specific Patient
DockHealthApi::Patient.delete({id: "12345"})


# List All Users
DockHealthApi::User.list
# Get Specific User
DockHealthApi::User.get('id of user')
# Create User
DockHealthApi::User.create(user_data)
# Update Specific User
DockHealthApi::User.update(updated_user_data)
# Delete Specific User (can't be an active user)
DockHealthApi::User.delete({id: "id of user"})

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
# List All Organizations
DockHealthApi::Organization.list

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

# Add existing user to tasklist
params = { taskList: { type: "tasklist type", id: "<tasklist id>" }, user: { type: "user type", id: "<user id>" } }
DockHealthApi::TaskList::User.put(params)
# Update role for existing user in tasklist
params = { taskList: { type: "tasklist type", id: "<tasklist id>" }, user: { type: "user type", id: "<user id>", userRole: "user role"} }
DockHealthApi::TaskList::User.update(params)
# Delete existing user from tasklist
params = { taskList: { type: "tasklist type", id: "<tasklist id>" }, user: { type: "user type", id: "<user id>" } }
DockHealthApi::TaskList::User.delete(params)

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

# Get Specific Organization
DockHealthApi::Organization.get('id of user')
# Create Organization
DockHealthApi::Organization.create(organization_data)
# Update Specific Organization
DockHealthApi::Organization.update(updated_organization_data)
# Delete Specific Organization (can't be an active Organization)
DockHealthApi::Organization.delete({id: "id of organization"})


```

# Patient Data Format
 ```
{
  "mrn": "string",
  "firstName": "string",
  "middleName": "string",
  "lastName": "string",
  "dob": "2019-08-24T14:15:22Z",
  "gender": "string",
  "email": "string",
  "phoneHome": "string",
  "phoneMobile": "string",
  "patientMetaData": [
    {
      "customFieldIdentifier": "string",
      "customFieldName": "string",
      "value": "string"
    }
  ],
  "identifier": "string"
}

required field
firstName, lastName, mrn

Updated Patient Data
{
  "email: "string,
  ...
  "id: "id of patient"
}
 ```
# User Data Format
 ```
{
  "email": "string",
  "firstName": "string",
  "lastName": "string",
  "credentials": "string",
  "accountPhoneNumber": "string",
  "workPhoneNumber": "string",
  "homePhoneNumber": "string",
  "faxNumber": "string",
  "department": "string",
  "notes": "string",
  "identifier": "string"
}

required field
email

Update User Format

{
  "email: "string,
  ...
  "id: "id of user"
}


 ```
# Task Data Format
 ```
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
 { "description": "string",
   "taskList": { type: "string", id: "<tasklist ID>" }
 }

 Update Task Format
 { "description": "string"}
   ...
   "id": "<tasklist ID"
 }

 List Tasks require field
 "taskListIdentifier", "patientIdentifier", "assignedToUserIdentifier", or "criteria"
 ```
# TaskList Data Format
```
{
  "listName": "string",
  "listDescription": "string",
  "creator": {
    "type": "DEVELOPER",
    "id": "string"
  },
  "listUsers": [
    {
      "user": {
        "type": "DEVELOPER",
        "id": "string"
      },
      "userRole": "OWNER"
    }
  ],
  "listType": "PUBLIC",
  "id": "string"
}

require field
listName

Update TaskList Format
{
  "listName": "string"
  ...
  "id": "<TaskList ID>"
}
```

# TaskList User Format
```
{
  "taskList": {
    "type": "DEVELOPER",
    "id": "string"
  },
  "user": {
    "type": "DEVELOPER",
    "id": "string"
  },
  "userRole": "OWNER"
}

require field
{
  "taskList": {
    "type": "DEVELOPER",
    "id": "string"
  },
  "user": {
    "type": "DEVELOPER",
    "id": "string"
  }
}

Update TaskList User Format
{
  "taskList": {
    "type": "DEVELOPER",
    "id": "string"
  },
  "user": {
    "type": "DEVELOPER",
    "id": "string"
  },
  "userRole": "OWNER"
}

Delete TaskList User Format
{
  "taskList": {
    "type": "DEVELOPER",
    "id": "string"
  },
  "user": {
    "type": "DEVELOPER",
    "id": "string"
  }
}
```

# Webhook Data Format
```
{
  "url": "string",
  "secret": "string",
  "verified": true,
  "enabled": true,
  "events": [
    {
      "description": "string",
      "type": "CREATE_TASK"
    }
  ],
  "id": "string"
}

require field
url, secret, events

Update Webhook Format
{
  "url": "string",
  "secret": "stringstringstringstringstringstring",

  "events": [
    "CREATE_TASK"
  ]
}
```

# Organization Data Format
 ```
{
  "domain": "string",
  "name": "string",
  "identifier": "string"
}

required field
domain, name

Update Organization Format

{
  "domain: "string,
  ...
  "id: "id of organization"
}

 ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/BreakthroughBehavioralInc/dock_health_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/BreakthroughBehavioralInc/dock_health_api/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
