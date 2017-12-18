[ ![Codeship Status for PirunSeng/hrms](https://app.codeship.com/projects/8b9305c0-c638-0135-d1ad-5a018f317e7c/status?branch=master)](https://app.codeship.com/projects/261138)

# HRMS

HRMS - Human Resource Management System replaced all your HR paper work by a simple yet powerful web application to keep track your new applications, interview, shortlist and hire as a full-time staff. Plus, it includes leave management system in which your staff will be able to send leave request, your management will review it and either accept or reject the request, and more.

### Requirements

* Postgres(>= 9.0)
* Ruby(2.4.2)
* Rails(5.1.4)

### Getting Start

Given that you got all the requirements running on your local machine.


Clone the project to your local machine:

```
  git clone git@github.com:PirunSeng/hrms.git
```

Navigate to the project directory and create `.env` in project root path, and copy all content in `.env.example` and replace all variable values to fit your local machine.

Then run:

```
  bundle install

  rake db:create

  rake db:migrate

  rake db:seed  # to load some basic data
```

Once the steps are done, start the server by running:

```
  rails server
```

Open a web browser and navigate to `http://localhost:3000`, and there you go!

### RSpec

Requirement

To run all specs, testing environment must be setup.
Navigate to project root directory and run the following commands:

```
  bundle install RAILS_ENV=test

  rake db:create RAILS_ENV=test

  rake db:migrate RAILS_ENV=test

  rake db:seed RAILS_ENV=test  # to load some basic data
```

To run all specs, in your project root directory in terminal, run this command:

```
  rspec
```

### Issue Reporting

If you experience with bugs or need further improvement, please create a new issue in the repo issue list.

### Contributing to HRMS

Pull requests are very welcome. Before submitting a pull request, please make sure that your changes are well tested. Pull requests without tests will not be accepted.

### Authors

HRMS is developed as an indivual portfolio of myself, Pirun Seng.

### License

HRMS Web Application is released under [AGPL](http://www.gnu.org/licenses/agpl-3.0-standalone.html)
