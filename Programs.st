// Main Lift Control Program (Project 1)
PROGRAM LiftControl
VAR
    liftUp : BOOL;      // Signal to move lift up
    liftDown : BOOL;    // Signal to move lift down
    liftAtFloor : INT;  // Current floor position
    floorRequest : INT; // Requested floor position
END_VAR

// Lift movement logic
IF liftUp THEN
    liftAtFloor := liftAtFloor + 1;
ELSIF liftDown THEN
    liftAtFloor := liftAtFloor - 1;
END_IF

// Floor request logic
IF floorRequest > liftAtFloor THEN
    liftUp := TRUE;
    liftDown := FALSE;
ELSIF floorRequest < liftAtFloor THEN
    liftUp := FALSE;
    liftDown := TRUE;
ELSE
    liftUp := FALSE;
    liftDown := FALSE;
END_IF


// Floor Selection Handling Program (Project 2)
PROGRAM FloorControl
VAR
    liftUp : BOOL;
    liftDown : BOOL;
    liftAtFloor : INT;
    floorRequest : INT;
    floorQueue : ARRAY[1..5] OF INT; // Array to store multiple floor requests
    i : INT;                         // Loop index
END_VAR

// Prioritize the floor requests
FOR i := 1 TO 5 DO
    IF floorQueue[i] > liftAtFloor THEN
        liftUp := TRUE;
        liftDown := FALSE;
    ELSIF floorQueue[i] < liftAtFloor THEN
        liftUp := FALSE;
        liftDown := TRUE;
    ELSE
        liftUp := FALSE;
        liftDown := FALSE;
    END_IF
END_FOR


// Door Automation Program (Project 3)
PROGRAM DoorControl
VAR
    doorOpen : BOOL;      // Door open signal
    doorClosed : BOOL;    // Door closed signal
    liftAtFloor : INT;    // Current floor position
    floorRequest : INT;   // Requested floor
END_VAR

// Door control logic
IF liftAtFloor = floorRequest THEN
    doorOpen := TRUE;  // Open door when lift reaches requested floor
    doorClosed := FALSE;
ELSE
    doorOpen := FALSE;
    doorClosed := TRUE;  // Keep door closed when lift is not at requested floor
END_IF


// Safety Mechanisms Program (Project 4)
PROGRAM SafetyControl
VAR
    doorOpen : BOOL;
    obstacleDetected : BOOL;    // Obstacle detection signal
    liftUp : BOOL;
    liftDown : BOOL;
    liftAtFloor : INT;
END_VAR

// Check for door status and obstacle detection
IF doorOpen THEN
    liftUp := FALSE;
    liftDown := FALSE;  // Stop the lift when door is open
ELSIF obstacleDetected THEN
    liftUp := FALSE;
    liftDown := FALSE;  // Stop the lift when an obstacle is detected
ELSE
    // Proceed with normal lift movement
    IF liftUp THEN
        liftAtFloor := liftAtFloor + 1;
    ELSIF liftDown THEN
        liftAtFloor := liftAtFloor - 1;
    END_IF
END_IF


// Emergency Stop Program (Project 5)
PROGRAM EmergencyStop
VAR
    emergencyStop : BOOL;      // Emergency stop signal
    liftUp : BOOL;
    liftDown : BOOL;
    doorOpen : BOOL;
    doorClosed : BOOL;
    liftAtFloor : INT;
END_VAR

// Emergency Stop Logic
IF emergencyStop THEN
    liftUp := FALSE;         // Stop the lift
    liftDown := FALSE;       // Stop the lift
    doorOpen := FALSE;       // Prevent door opening
    doorClosed := TRUE;      // Keep the door closed
END_IF


// Manual Override Program (Project 6)
PROGRAM ManualControl
VAR
    manualLiftUp : BOOL;         // Manual signal to move lift up
    manualLiftDown : BOOL;       // Manual signal to move lift down
    manualDoorOpen : BOOL;       // Manual signal to open door
    manualDoorClose : BOOL;      // Manual signal to close door
    emergencyStop : BOOL;        // Emergency stop signal
    liftAtFloor : INT;           // Current floor position
END_VAR

// Manual Control Logic
IF emergencyStop THEN
    manualLiftUp := FALSE;       // Disable manual control if emergency stop is active
    manualLiftDown := FALSE;     // Disable manual control if emergency stop is active
    manualDoorOpen := FALSE;     // Disable manual door control if emergency stop is active
    manualDoorClose := TRUE;     // Keep door closed
ELSE
    IF manualLiftUp THEN
        liftAtFloor := liftAtFloor + 1;  // Move lift up manually
    ELSIF manualLiftDown THEN
        liftAtFloor := liftAtFloor - 1;  // Move lift down manually
    END_IF

    IF manualDoorOpen THEN
        // Open door manually
    ELSIF manualDoorClose THEN
        // Close door manually
    END_IF
END_IF
