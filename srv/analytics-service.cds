// srv/analytics-service.cds
using { com.epm as db } from '../db/schema';

service AnalyticsService @(path: '/analytics') {
    action GenerateReport(
    reportType : String(20),
    startDate  : Date,
    endDate    : Date
) returns {
    reportId   : UUID;
    status     : String(20);
    message    : String(200);
};

  // Unbound action — belongs to the service, not an entity


  // Another unbound action — no parameters
  action PingHealth() returns {
    status    : String(10);
    timestamp : DateTime;
    version   : String(20);
  };

  @readonly entity ProductCatalog as projection on db.Products;
}