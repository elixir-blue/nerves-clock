# Nerves Clock

Use Linux, Erlang, Elixir and other kinds of overkill to make an LED clock for some reason.

## Building

Uses the [poncho project][nerves-poncho] approach to bundle applications together in the firmware.

### UI

The UI assets and dependencies need to be available before running a firmware build.

```shell
$ MIX_TARGET=host MIX_ENV=dev mix do deps.get, assets.deploy
```

### Firmware

Only tested with Raspberry Pi Zero W, so using the rpi0 target.

```shell
$ MIX_TARGET=rpi0 mix do deps.get, firmware, upload
```

## Useful Links

* Nerves docs: https://hexdocs.pm/nerves/getting-started.html
* Nerves website: https://nerves-project.org/
* Nerves Forum: https://elixirforum.com/c/nerves-forum
* Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))

[nerves-poncho]: https://hexdocs.pm/nerves/user-interfaces.html#create-a-poncho-project
