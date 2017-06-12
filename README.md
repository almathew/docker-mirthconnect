# ![](https://gravatar.com/avatar/11d3bc4c3163e3d238d558d5c9d98efe?s=64) aptible/docker-mirthconnect

A Dockerized installer for the open-source [Mirth Connect](https://www.nextgen.com/Interoperability/Mirth-Solutions/Connect-Overview?tab=true) HL7 application, designed for easy setup on Aptible,

## Deployment

To deploy:

1. From the Aptible Dashboard or Aptible Toolbelt, create a new app in which to deploy. For example:

        aptible apps:create --environment my-environment mirthconnect

2. Deploy the latest version of this app via `aptible deploy`. For example:

        aptible deploy --app mirthconnect --docker-image quay.io/aptible/mirthconnect

By default, this Mirth Connect application will use an in-container Derby database, which **will be destroyed every time the app is restarted or re-deployed.** For this reason, we strongly recommend that you configure your app to use a dedicated PostgreSQL database instead. To do so, create a new PostgreSQL database (from the Aptible Dashboard or using `aptible db:create`), then set this database's URL as the `$DATABASE_URL` for your app. For example:

        aptible config:set --app mirthconnect DATABASE_URL=...

## Copyright and License

MIT License, see [LICENSE](LICENSE.md) for details.

Copyright (c) 2017 [Aptible](https://www.aptible.com) and contributors.
