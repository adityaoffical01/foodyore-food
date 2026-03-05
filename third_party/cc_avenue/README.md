# cc_avenue

cc_avenue payment gateway non-seamless

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


<p align="left">
<a href="https://pub.dev/packages/cc_avenue/"><img src="https://img.shields.io/pub/v/cc_avenue" alt="Pub"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
</p>


### As of now this package supports only Android

### Call this as Async. You job is done!

### if you are working with test environment please update the [transUrl] as ``` https://test.ccavenue.com/transaction/initTrans ```
```
CcAvenue.cCAvenueInit(
        transUrl: 'https://secure.ccavenue.com/transaction/initTrans',
        accessCode: '4YRUXLSRO20O8NIH',
        amount: '10',
        cancelUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
        currencyType: 'INR',
        merchantId: '2',
        orderId: '519',
        redirectUrl: 'http://122.182.6.216/merchant/ccavResponseHandler.jsp',
        rsaKeyUrl: 'https://secure.ccavenue.com/transaction/jsp/GetRSA.jsp'
      );
```
### Features

![Screenshot](https://github.com/avinash-gotluru/cc_avenue/blob/eb9841c6c6e8bf4934516b42d8c16ff808a31543/images/Screenshot%202022-08-03%20at%203.00.51%20PM.png)
![Screenshot](https://github.com/avinash-gotluru/cc_avenue/blob/eb9841c6c6e8bf4934516b42d8c16ff808a31543/images/Screenshot%202022-08-03%20at%203.01.09%20PM.png)
![Screenshot](https://github.com/avinash-gotluru/cc_avenue/blob/eb9841c6c6e8bf4934516b42d8c16ff808a31543/images/Screenshot%202022-08-03%20at%203.01.34%20PM.png)
![Screenshot](https://github.com/avinash-gotluru/cc_avenue/blob/eb9841c6c6e8bf4934516b42d8c16ff808a31543/images/Screenshot%202022-08-03%20at%203.01.50%20PM.png)
