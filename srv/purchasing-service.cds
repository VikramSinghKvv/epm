using { com.epm as db } from '../db/schema';

service PurchasingService @(path: '/purchasing', requires: 'authenticated-user') {

  @odata.draft.enabled
  entity PurchaseOrders @(restrict: [
    { grant: 'READ', to: 'Viewer', where: 'status = ''Approved'' or status = ''Received''' },
    { grant: ['READ', 'CREATE', 'UPDATE'], to: 'PurchaseManager', where: 'createdBy = $user' },
    { grant: 'READ', to: 'PurchaseManager', where: 'status = ''Submitted''' },
    { grant: '*', to: 'Administrator' }
  ]) as projection on db.PurchaseOrders
    actions {
      @(requires: 'PurchaseManager')
      action submit() returns { status: String; message: String; };
      @(requires: ['PurchaseManager', 'Administrator'])
      action approve(comment: String) returns { status: String; message: String; };
      @(requires: ['PurchaseManager', 'Administrator'])
      action reject(reason: String) returns { status: String; message: String; };
    };

  entity PurchaseOrderItems @(restrict: [
    { grant: 'READ', to: 'Viewer' },
    { grant: '*', to: ['PurchaseManager', 'Administrator'] }
  ]) as projection on db.PurchaseOrderItems;

  @readonly entity Products as projection on db.Products;

  @(requires: 'Administrator')
  entity Suppliers as projection on db.Suppliers;
}
