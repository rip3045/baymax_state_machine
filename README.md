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
