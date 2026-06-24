sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"epm/purchase/test/integration/pages/PurchaseOrdersList",
	"epm/purchase/test/integration/pages/PurchaseOrdersObjectPage"
], function (JourneyRunner, PurchaseOrdersList, PurchaseOrdersObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('epm/purchase') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseOrdersList: PurchaseOrdersList,
			onThePurchaseOrdersObjectPage: PurchaseOrdersObjectPage
        },
        async: true
    });

    return runner;
});

