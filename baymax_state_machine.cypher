// Create nodes for Baymax states
CREATE (:State {name: 'Idle'}),
       (:State {name: 'Activation'}),
       (:State {name: 'Diagnosis Mode'}),
       (:State {name: 'Care Mode'}),
       (:State {name: 'Flight Mode'}),
       (:State {name: 'Combat Mode'}),
       (:State {name: 'Low Battery'}),
       (:State {name: 'Maintenance Mode'}),
       (:State {name: 'Deactivation'});

// Create relationships with action labels
MATCH (idle:State {name: 'Idle'}),
      (activation:State {name: 'Activation'}),
      (diagnosis:State {name: 'Diagnosis Mode'}),
      (care:State {name: 'Care Mode'}),
      (flight:State {name: 'Flight Mode'}),
      (combat:State {name: 'Combat Mode'}),
      (lowBattery:State {name: 'Low Battery'}),
      (maintenance:State {name: 'Maintenance Mode'}),
      (deactivation:State {name: 'Deactivation'})

CREATE (idle)-[:ACTIVATE {label: 'activate'}]->(activation),
       (activation)-[:DIAGNOSE {label: 'diagnose'}]->(diagnosis),
       (diagnosis)-[:CARE {label: 'care'}]->(care),
       (diagnosis)-[:FLY {label: 'fly'}]->(flight),
       (care)-[:END_CARE {label: 'end_care'}]->(idle),
       (care)-[:FLY {label: 'fly'}]->(flight),
       (activation)-[:ENGAGE_COMBAT {label: 'engage_combat'}]->(combat),
       (combat)-[:LOW_BATTERY_ALERT {label: 'low_battery_alert'}]->(lowBattery),
       (care)-[:LOW_BATTERY_ALERT {label: 'low_battery_alert'}]->(lowBattery),
       (lowBattery)-[:MAINTAIN {label: 'maintain'}]->(maintenance),
       (activation)-[:LOW_BATTERY_ALERT {label: 'low_battery_alert'}]->(lowBattery),
       (maintenance)-[:ACTIVATE {label: 'activate'}]->(activation),
       (activation)-[:DEACTIVATE {label: 'deactivate'}]->(deactivation),
       (deactivation)-[:RESET {label: 'reset'}]->(idle);

// Query to return the full graph
MATCH (s:State)-[r]->(t:State)
RETURN s, r, t;
