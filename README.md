# Odin Facebook
This is the final project of the Ruby on Rails part from the curriculum of The Odin Project.
https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project?ref=lnav

This project contains the core pieces of facebook, which include – users, profiles, “friending”, posts, news feed, and “liking”. The sign-in is implemented by using Omniauth and Devise.


## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

Or test the deployed version on heroku:

## Notes

### PostgreSQL differences

Creating a self-referential association in sqlite looks something like this. 

`friend_id` will be a foreign key which actually points to another user in the `users` table.

```
create_table :friendships do |t|
  t.references :friend, foreign_key: true
```

But postgres actually checks that references are valid and will complain: `PG::UndefinedTable: ERROR:  relation "friends" does not exist`

We just need to tell it which table the foreign key is actually intended for.

```
create_table :friendships do |t|
  t.references :friend, foreign_key: { to_table: :users }
```

