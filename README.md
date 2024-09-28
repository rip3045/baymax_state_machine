# Understanding State Machines: The Baymax Example

A **state machine** is a conceptual model that defines an object, system, or machine's behavior in terms of a series of **states** and **transitions** between those states based on events or triggers. 

In this walkthrough, we'll use the character **Baymax** from the movie *Big Hero 6* as an example to explain state machines. Baymax, being a healthcare companion robot, has various behaviors or "states" that he transitions through as events occur in the story.

## Key Concepts in State Machines

- **State**: A condition or situation in which an object (like Baymax) can be at any given time.
- **Event/Trigger**: A stimulus or action that causes a transition from one state to another.
- **Transition**: The change from one state to another, triggered by an event.

---

## Baymax's State Machine

### States of Baymax
Baymax can be in any of the following states:

1. **Idle**: Baymax is in standby mode, waiting to be activated.
2. **Activation**: Baymax is turned on and begins checking for health-related issues.
3. **Diagnosis Mode**: Baymax scans the patient to determine their health condition.
4. **Care Mode**: Baymax provides treatment or care after diagnosing an issue.
5. **Flight Mode**: Baymax flies to different locations.
6. **Combat Mode**: Baymax engages in combat when equipped with combat protocols.
7. **Low Battery**: Baymax's battery is low, and his behavior is affected.
8. **Maintenance Mode**: Baymax enters maintenance to restore his system after low battery or damage.
9. **Deactivation**: Baymax is powered down after completing his care duties.

### Transitions Between States
Baymax's transitions between states are caused by specific events or triggers. Here's a high-level look at how Baymax moves through these states:

- **Idle → Activation**: When someone says "Ow" or requests help, Baymax activates.
- **Activation → Diagnosis Mode**: Baymax scans the person to diagnose any health issues.
- **Diagnosis Mode → Care Mode**: If a health issue is found, Baymax provides care.
- **Diagnosis Mode → Flight Mode**: If no health issues are detected and Baymax is commanded to fly, he enters flight mode.
- **Care Mode → Idle**: After treatment is provided, Baymax returns to standby.
- **Activation → Combat Mode**: When combat protocols are activated, Baymax transitions to combat mode.
- **Any State → Low Battery**: When Baymax’s battery is low, he transitions to low battery mode.
- **Low Battery → Maintenance Mode**: Baymax performs maintenance when his battery is low.
- **Any State → Deactivation**: Baymax powers down after receiving a deactivation command.

### Diagram of Baymax's State Machine

Below is a basic diagram representing the states and transitions for Baymax:

```plaintext
 Idle 
   | activate
   v
 Activation
   | diagnose
   v
 Diagnosis Mode ---> Flight Mode
   | care          /          
   v              /
 Care Mode ------> Idle
   | end_care
   | low_battery_alert
   v
 Low Battery -----> Maintenance Mode
   | maintain      |
   | activate      v
   |               Activation
 Combat Mode -------> Deactivation
```

Output:
```
Initial state: idle
After activation: activation
After diagnosis: diagnosis_mode
After providing care: care_mode
After ending care: idle
Low battery alert: low_battery
After maintenance: maintenance_mode
After deactivation: deactivation
Reset to: idle
```

## Implementing Baymax's State Machine in Neo4j

Now that you have a conceptual understanding of Baymax's state machine, let's dive into the practical implementation using **Neo4j**.

We'll represent the **states** of Baymax as **nodes** and the **transitions** between them as **relationships**. The transitions are triggered by specific actions or events (such as "activate" or "care").

### Step 1: Create the Nodes (States)
Each state in Baymax's behavior model is represented as a node in the graph. Here's how you can create the nodes for the states using Cypher queries in Neo4j:

```cypher
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
```

In this query:

Each state (such as Idle, Activation, Diagnosis Mode, etc.) is created as a node labeled State with a property name that corresponds to the name of the state.

## Step 2: Create the Relationships (Transitions)
The transitions between states are represented as relationships in the graph. We will add an event trigger (action) for each transition in the form of a label on the relationships.

```// Create relationships between states with action labels
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
```


## Explanation:

The MATCH clause identifies the nodes (states) we created earlier.
The CREATE clause adds relationships (transitions) between the states.
Each relationship has a label property that describes the action that triggers the transition (e.g., activate, care, fly, etc.).

## Step 3: Query and Visualize the State Machine
Once the nodes and relationships are in place, you can query the entire state machine to visualize it.

```// Query to return all nodes and relationships
MATCH (s:State)-[r]->(t:State)
RETURN s, r, t;
```

This query will display all the states and transitions in your Neo4j database, allowing you to see how Baymax moves between different states based on the defined actions.

## Full Cypher Script
Here is the full Cypher script, which you can run directly in Neo4j to create the Baymax state machine:

```// Create nodes for Baymax states
CREATE (:State {name: 'Idle'}),
       (:State {name: 'Activation'}),
       (:State {name: 'Diagnosis Mode'}),
       (:State {name: 'Care Mode'}),
       (:State {name: 'Flight Mode'}),
       (:State {name: 'Combat Mode'}),
       (:State {name: 'Low Battery'}),
       (:State {name: 'Maintenance Mode'}),
       (:State {name: 'Deactivation'});

// Create relationships between states with action labels
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
```

## Running the Script
1. Open your Neo4j browser or connect to your Neo4j instance via cypher-shell.
2. Paste the full script into the query editor and run it.
3. Execute the .cypher Script:

* Using Neo4j Browser: You can copy the content of the .cypher file and paste it into the Neo4j Browser query editor.

*Using cypher-shell: If you have Neo4j installed locally, you can execute the .cypher file using cypher-shell from the command line:

```
cypher-shell -u neo4j -p your_password -f baymax_state_machine.cypher
```

By running this Neo4j example, you now have a visual, interactive model of Baymax's state machine, helping you better understand how state machines work in practice.

![ScreenShot](/baymax_state_graph.png)


### How to Use
- Copy the above markdown and add it as part of your GitHub walkthrough.
- It includes the **Cypher** code snippets for creating and querying the state machine, along with explanations of how each step works.
