using { com.epm as db } from '../db/schema';

service ReportService @(path:'/ReportService') {

    entity ProductReport as projection on db.Products;

    entity SalesReport as projection on db.SalesOrders; 
}