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

# List All Organizations
DockHealthApi::Organization.list
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

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cigna_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/cigna_api/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).