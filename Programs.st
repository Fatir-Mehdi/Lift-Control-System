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
