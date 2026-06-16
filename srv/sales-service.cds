 using {com.epm as db} from '../db/schema';
// service SalesService @(path:'/SalesService') {
    
//     entity Suppliers as projection on epm.Suppliers;
//     entity Categories as projection on epm.Categories;
//     entity Products as projection on epm.Products;
//     entity Customers as projection on epm.Customers;
//     entity SalesOrders as projection on epm.SalesOrders;
//     entity salesOrderItems as projection on epm.SalesOrderItems;
//     entity PurchaseOrders as projection on epm.PurchaseOrders;
//     entity purchaseOrderItems as projection on epm.PurchaseOrderItems;



// }
service SalesService @(path: '/sales') {
  @odata.draft.enabled: true

  entity SalesOrders as projection on db.SalesOrders
    actions {
      action confirm() returns { status: String; message: String; };
      action cancel(reason: String(500)) returns { status: String; message: String; };
      action ship(trackingNumber: String(50),
      carrier: String(50)) returns { status: String; };
    };

  entity Customers as projection on db.Customers;
}

// srv/sales-service.cds
//using { com.epm as db } from '../db/schema';

// service SalesService @(path: '/sales') {

//   entity SalesOrders as projection on db.SalesOrders;
//   entity Customers as projection on db.Customers;

//   // Bound action — tied to SalesOrders entity
//   // "You can call this action ON a specific order"
//   action confirmOrder() returns {
//     status  : String(20);
//     message : String(200);
//   };

//   action cancelOrder(
//     reason : String(500)       // Why are you cancelling?
//   ) returns {
//     status  : String(20);
//     message : String(200);
//     refundAmount : Decimal(12,2);
//   };

//   action shipOrder(
//     trackingNumber : String(50),
//     carrier        : String(50)
//   ) returns {
//     status       : String(20);
//     message      : String(200);
//     estimatedDelivery : Date;
//   };

// }
