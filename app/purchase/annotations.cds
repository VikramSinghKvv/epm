using {PurchasingService} from '../../srv/purchasing-service';

annotate PurchasingService.PurchaseOrders with @(
  UI                          : {

    SelectionFields    : [
      poNumber,
      status,
      supplier_ID,
      orderDate
    ],

    LineItem           : [
      {
        Value: poNumber,
        Label: 'PO Number'
      },
      {
        Value: supplier.name,
        Label: 'Supplier'
      },
      {
        Value: orderDate,
        Label: 'Order Date'
      },
      {
        Value: totalAmount,
        Label: 'Total Amount'
      },
      {
        Value: taxAmount,
        Label: 'Tax Amount'
      },
      {
        Value: netAmount,
        Label: 'Net Amount'
      },
      {
        Value: currency_code,
        Label: 'Currency'
      },
      {
        Value: status,
        Label: 'Status',
        Criticality : criticality

      }
    ],

    HeaderInfo         : {
      TypeName      : 'Purchase Order',
      TypeNamePlural: 'Purchase Orders',
      Title         : {Value: poNumber},
      Description   : {Value: supplier.name}
    },

    Facets             : [
      {
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#General',
        Label : 'General Information'
      },
      {
        $Type : 'UI.ReferenceFacet',
        Target: 'items/@UI.LineItem',
        Label : 'Purchase Order Items'
      },
      {
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.DataPoint#BudgetUtilization',
        Label : 'Budget Utilization'
      }
    ],

    FieldGroup #General: {Data: [
      {
        Value: poNumber,
        Label: 'PO Number'
      },
      {
    Value: supplier_ID,
    Label: 'Supplier'
  },
      {
        Value: supplier.name,
        Label: 'Supplier'
      },
      {
        Value: orderDate,
        Label: 'Order Date'
      },
      {
        Value: totalAmount,
        Label: 'Total Amount'
      },
      {
        Value: taxAmount,
        Label: 'Tax Amount'
      },
      {
        Value: netAmount,
        Label: 'Net Amount'
      },
      {
        Value: currency_code,
        Label: 'Currency'
      },
      {
        Value: status,
        Label: 'Status'
      }
    ]},


    Identification     : [
      {
        $Type : 'UI.DataFieldForAction',
        Action: 'PurchasingService.submit',
        Label : 'Submit'
      },
      {
        $Type : 'UI.DataFieldForAction',
        Action: 'PurchasingService.approve',
        Label : 'Approve'
      },
      {
        $Type : 'UI.DataFieldForAction',
        Action: 'PurchasingService.reject',
        Label : 'Reject'
      },
      {
        $Type : 'UI.DataFieldForAction',
        Action: 'PurchasingService.receive',
        Label : 'Receive'
      }
    ]
  },
  UI.DataPoint #totalAmount   : {
    $Type: 'UI.DataPointType',
    Value: totalAmount,
    Title: 'totalAmount',
  },
UI.DataPoint #BudgetUtilization : {
    $Type         : 'UI.DataPointType',
    Title         : 'Budget Utilization',
    Value         : netAmount,
    TargetValue   : 15000000,
    Visualization : #Progress
},

  // UI.HeaderFacets : [
  // {
  //   $Type : 'UI.ReferenceFacet',
  //   Label : 'Budget Utilization',
  //   Target : '@UI.DataPoint#BudgetUtilization'
  // },
//],
  UI.FieldGroup #PurchaseOrder: {
    $Type: 'UI.FieldGroupType',
    Data : [],
  },
);

annotate PurchasingService.PurchaseOrderItems with @UI: {

  LineItem              : [
    {
      Value: product.name,
      Label: 'Product'
    },
    {
      Value: quantity,
      Label: 'Quantity'
    },
    {
      Value: unitPrice,
      Label: 'Unit Price'
    }
  ],

  HeaderInfo            : {
    TypeName      : 'PO Item',
    TypeNamePlural: 'PO Items',
    Title         : {Value: product.name},
    Description   : {Value: order.poNumber}
  },

  Facets                : [
    {
      $Type : 'UI.ReferenceFacet',
      Target: '@UI.FieldGroup#ItemDetail',
      Label : 'Item Details'
    },
    {
      $Type : 'UI.ReferenceFacet',
      Target: 'product/@UI.FieldGroup#ProductDetail',
      Label : 'Product Information'
    }
  ],
  FieldGroup #ItemDetail: {Data: [
    {
      Value: order.poNumber,
      Label: 'PO Number'
    },
    {
      Value: product.name,
      Label: 'Product Name'
    },
    {
      Value: product.description,
      Label: 'Description'
    },
    {
      Value: quantity,
      Label: 'Quantity Ordered'
    },
    {
      Value: unitPrice,
      Label: 'Unit Price'
    },
    {
      Value: product.price,
      Label: 'Current Product Price'
    },
    {
      Value: product.stock,
      Label: 'Current Stock'
    },
    {
      Value: product.rating,
      Label: 'Rating'
    },
    {
      Value: product.supplier.name,
      Label: 'Supplier'
    }
  ]}
};

annotate PurchasingService.PurchaseOrders with {
  supplier @(Common: {
    Text           : supplier.name,
    TextArrangement: #TextOnly,
    ValueList      : {
      CollectionPath: 'Suppliers',
      Parameters    : [
        {
          $Type            : 'Common.ValueListParameterInOut',
          LocalDataProperty: supplier_ID,
          ValueListProperty: 'ID'
        },
        {
          $Type            : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty: 'name'
        },
        {
          $Type            : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty: 'email'
        },
        {
          $Type            : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty: 'city'
        }
      ]
    }
  });
};

annotate PurchasingService.PurchaseOrderItems with {
  product @(Common: {
    Text           : product.name,
    TextArrangement: #TextOnly,
    ValueList      : {
      CollectionPath: 'Products',
      Parameters    : [
        {
          $Type            : 'Common.ValueListParameterInOut',
          LocalDataProperty: product_ID,
          ValueListProperty: 'ID'
        },
        {
          $Type            : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty: 'name'
        },
        {
          $Type            : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty: 'price'
        },
        {
          $Type            : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty: 'stock'
        }
      ]
    }
  });
};

annotate PurchasingService.Products with @UI: {

  HeaderInfo               : {
    TypeName      : 'Product',
    TypeNamePlural: 'Products',
    Title         : {Value: name},
    Description   : {Value: description}
  },

  Facets                   : [{
    $Type : 'UI.ReferenceFacet',
    Target: '@UI.FieldGroup#ProductDetail',
    Label : 'Product Details'
  }],

  FieldGroup #ProductDetail: {Data: [
    {
      Value: name,
      Label: 'Product Name'
    },
    {
      Value: description,
      Label: 'Description'
    },
    {
      Value: price,
      Label: 'Price'
    },
    {
      Value: stock,
      Label: 'Stock'
    },
    {
      Value: minStock,
      Label: 'Minimum Stock'
    },
    {
      Value: rating,
      Label: 'Rating'
    },
    {
      Value: supplier.name,
      Label: 'Supplier'
    }
  ]}
};

annotate PurchasingService.Products with {
  supplier
  @Common.Text           : supplier.name
  @Common.TextArrangement: #TextOnly;
};


// ---------------------------------------------------------------------
// Side Effects — recalc totals when items / quantity / price change
// ---------------------------------------------------------------------
annotate PurchasingService.PurchaseOrderItems with @(
  Common.SideEffects: {
    SourceProperties: ['quantity', 'unitPrice'],
    TargetProperties: ['totalPrice']
  }
);

annotate PurchasingService.PurchaseOrders with @(
  Common.SideEffects#ItemsChanged: {
    SourceEntities  : ['items'],
    TargetProperties: ['totalAmount']
  }
);