# Standard Branding for QuickPay Payment Window

This repository contains the standard branding for the [QuickPay Payment Window](https://learn.quickpay.net/tech-talk/payments/form/).

A branding is a collection of resources (templates, stylesheets, images etc.) which defines the UI. You can clone/copy this, adapt it to your liking and upload it to your merchant or reseller account at https://manage.quickpay.net.

**Note**: We use the [Liquid](https://github.com/Shopify/liquid) template engine.

#### Limitations

* The total file size must be less than 1MB.
* Is is not possible to add javascript or other programming languages.

## Configuration

The [config.json](https://github.com/QuickPay/standard-branding/tree/master/config.json) file allows you to specify some arbitrary configuration. This can be fetched in the liquid templates using `{% config.* %}`.

Currently it supports:

* `title` (string, default: null), when set, uses the value as HTML title in the payment window. Otherwise the merchant shop name is used.
* `enable_card_holder_field` (boolean, default: false), adds "Card holder name" input field to the credit/debit card form.
* `enable_3d_card_field` (boolean, default: false), adds a checkbox for letting card holder force 3D Secure on payment.
* `enable_prefill_name` (boolean, default: false), prefills name for "Card holder name" input field to the credit/debit card form.
* `enable_amount_for_subscription` (boolean, default: false), displays amount while creating the subscription.
* `autojump` (boolean, default: false), makes the cursor autojump to the next field when entering card information.

The configuration can be access using a Liquid Drop `config` - example: `{% if config.enable_3d_card_field %}`

Example config file:

```json
{
  "title": "My Webshop Inc.",
  "enable_card_holder_field": false,
  "enable_3d_card_field": false,
  "enable_prefill_name": false,
  "enable_amount_for_subscription": false,
  "autojump": true,
  "my_own_custom_key": "Access this value in a template with {% config.my_own_custom_key %}"
}
```

## Language and Translation <a style="float: right" href="https://translate.quickpay.net/projects/quickpay/standard-branding/"><img src="http://translate.quickpay.net/widgets/quickpay/-/standard-branding/svg-badge.svg" alt="Translation status" /></a>

Translation is handled using the well known and battle tested [Gettext](https://www.gnu.org/software/gettext/) library which means that new languages and translations can easily be added.

If you want to contribute to the translation of this project, please ask our [support team](mailto:support@quickpay.net) for an account with our [online translation tool](https://translate.quickpay.net/projects/quickpay/standard-branding-v2xx/). The [translation files](https://github.com/QuickPay/standard-branding/tree/2.x.x/locales) can also be edited in any text-editor or using special editors like [Poedit](https://poedit.net).

Translatable string are defined using the Liquid Tag `t` - example: `{% t To be translated %}`

## Versioning

The [VERSION](https://github.com/QuickPay/standard-branding/tree/master/VERSION) file specifies the branding version. This must correspond to one of the [releases](https://github.com/QuickPay/standard-branding/releases) of this project.

## Contributions

To contribute:

1. Fork, fix and submit a pull request
2. World is now a better place! :)
