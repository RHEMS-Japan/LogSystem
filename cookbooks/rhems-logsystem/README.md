rhems-logsystem Cookbook
========================
TODO: Enter the cookbook description here.

```
json
{
  "name": "RHEMSLABS_logserver",
  "chef_environment": "rhems-labs",
  "normal": {
    "rsyslogconf": {
      "aclip": "127.0.0.1 10.0.0.0/8"
    },
    "tags": [

    ]
  },
  "run_list": [
    "role[role_rhemslogserver]"
  ]
}
```
