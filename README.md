# Standard Branding for QuickPay Payment Window

This repository contains the standard branding for the [QuickPay Payment Window](https://learn.quickpay.net/tech-talk/form/).

A branding is a collection of resources (templates, stylesheets, images etc.) which defines the UI. You can clone/copy this, adapt it to your liking and upload it to your merchant or reseller account at https://manage.quickpay.net.

**Note**: The total file size must be less than 1MB.

## Documentation

The branding feature uses [Liquid](https://github.com/Shopify/liquid) as its templating system.

#### Extra Liquid filters

* translate
* currency
* newline_to_p

## Configuration

The [config.json](https://github.com/QuickPay/standard-branding/tree/master/config.json) file allows you to specify some arbitrary configuration. This can be fetched in templates using `{% config.* %}`.

## Versioning

The [VERSION](https://github.com/QuickPay/standard-branding/tree/master/VERSION) specifies the branding version. This must correspond to one of the [releases](https://github.com/QuickPay/standard-branding/releases) of this project.

## Collaboration
