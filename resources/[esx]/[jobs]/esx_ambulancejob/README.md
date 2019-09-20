# esx_ambulancejob

## Original

- [esx_ambulancejob](https://github.com/ESX-Org/esx_ambulancejob)

## Added
* Mission
* Billing
* Death Screen

## Requirements

* Auto mode
   - [esx_skin](https://github.com/ESX-Org/esx_skin)

* Player management
   - [esx_society](https://github.com/ESX-Org/esx_society)
   - [esx_billing](https://github.com/FXServer-ESX/fxserver-esx_billing)

## Installation
- Import `esx_ambulancejob.sql` in your database
- If you want player management you have to set `Config.EnablePlayerManagement` to `true` in `config.lua`
- Add this in your `server.cfg`:

```
start esx_ambulancejob
```

