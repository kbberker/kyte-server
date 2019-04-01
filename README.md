# Kyte API

### Installing & Setup

After cloning the repo, in the terminal you should run

```
bundle install
```

Before you can start the server you will need an API key from [Kyte](www.gokyte.com).<br>
Once you have one you will need to configure the `config/credentials.yml.enc` file. Instructions on how to do that can be found [here](https://www.viget.com/articles/storing-secret-credentials-in-rails-5-2-and-up/)

### Running

Once you are all setup, you can start the server in the termiinal with

```
rails s
```

After that you are good to start the [Kyte Client](https://github.com/kbberker/kyte-client) (you can follow the instructions there to get it running).

This README would normally document whatever steps are necessary to get the
application up and running.

## Built With

- Rails 5.2.3

- [rest-client](https://github.com/rest-client/rest-client) - HTTP and REST client for Ruby
