### Project 05 Sequence with Door Control

![image](https://github.com/user-attachments/assets/6c0f462f-2796-4ee8-8e7c-d428adc7a226)


Creating a door control sequence that manages the door opening and closing operations of a lift. This control is linked to the main lift control program, and the door control function block should have specific sequence steps with transition conditions.

### Solution Structure

The solution involves creating a door control function block (FB) with specific sequence logic. The sequence will run through different steps, opening and closing the doors with appropriate delays, based on the elevator's position and command inputs.

### Inputs and Outputs
1. **Inputs:**
   - `Open_Door`: Command to open the door.
   - `Door_Closed`: Position switch indicating whether the door is closed.
   - `Init`: Initialization of the step sequence.
   
2. **Outputs:**
   - `Select`: Determines whether the door should be opened or closed.
   - `Move_Door`: Controls the opening and closing of the door.
   - `Ready`: Indicates readiness of the step sequence.

### Function Block Design (ST Language)

```structured-text
FUNCTION_BLOCK DoorControl
VAR_INPUT
    Open_Door: BOOL;       // Command to open the door
    Door_Closed: BOOL;     // Input for position switch indicating door status
    Init: BOOL;            // Input for initialisation of step sequence
END_VAR

VAR_OUTPUT
    Select: BOOL;          // Output to select door open or close
    Move_Door: BOOL;       // Output for controlling door movement
    Ready: BOOL;           // Output to indicate readiness of step sequence
END_VAR

VAR
    Step_1: BOOL := FALSE; // Step 1: Waiting
    Step_2: BOOL := FALSE; // Step 2: Opening door
    Step_3: BOOL := FALSE; // Step 3: Delay before closing
    Step_4: BOOL := FALSE; // Step 4: Closing door
    Timer1: TON;           // Timer for opening the door
    Timer2: TON;           // Timer for closing the door
END_VAR

// Step 1: Wait until initialization
IF Init THEN
    Step_1 := TRUE;
    Ready := TRUE;
    Timer1(IN := FALSE); // Disable timers at initialization
    Timer2(IN := FALSE);
ELSE
    Step_1 := FALSE;
    Ready := FALSE;
END_IF

// Step 2: Door opening sequence
IF Step_1 AND Open_Door THEN
    Step_2 := TRUE;
    Select := TRUE;  // Open door command
    Move_Door := TRUE;  // Move door to open position
    Timer1(IN := TRUE, PT := T#7S); // Start 7 second timer for opening
    IF Timer1.Q THEN
        Step_2 := FALSE;
        Step_3 := TRUE;  // Transition to Step 3 after 7 seconds
        Timer1(IN := FALSE); // Reset the timer
    END_IF
END_IF

// Step 3: Delay before closing door
IF Step_3 THEN
    Timer2(IN := TRUE, PT := T#3S);  // 3 seconds delay for door open
    IF Timer2.Q THEN
        Step_3 := FALSE;
        Step_4 := TRUE;  // Transition to Step 4 after 3 seconds
        Timer2(IN := FALSE); // Reset the timer
    END_IF
END_IF

// Step 4: Door closing sequence
IF Step_4 THEN
    Move_Door := FALSE;  // Command to close the door
    IF Door_Closed THEN
        Step_4 := FALSE;  // Transition back to Step 1 after door is closed
        Step_1 := TRUE;
    END_IF
END_IF
END_FUNCTION_BLOCK
```

### Explanation of Code
1. **Step 1**: Wait for initialization. When the `Init` input is `TRUE`, the sequence is set to Step 1. The `Ready` signal is activated, indicating that the system is ready for operation.
   
2. **Step 2**: The sequence waits for the `Open_Door` input to be `TRUE`, and when triggered, it opens the door (`Select` is set to `TRUE` and `Move_Door` to `TRUE`). The `Timer1` is started with a delay of 7 seconds to simulate the door opening. Once the timer completes, the sequence transitions to Step 3.

3. **Step 3**: After the door is opened for 7 seconds, a 3-second delay is introduced using `Timer2`. Once the delay is completed, the sequence transitions to Step 4.

4. **Step 4**: The door is closed by setting `Move_Door` to `FALSE`. The sequence waits for the `Door_Closed` signal. When the door is closed, the sequence transitions back to Step 1, ready for the next cycle.

### Additional Variables
- **Step_1, Step_2, Step_3, Step_4**: Boolean variables to represent the different states in the sequence.
- **Timer1 and Timer2**: TON timers for implementing delays (7 seconds for opening and 3 seconds for staying open).

### Variables in the Main Program
In your main program, declare the necessary variables and instantiate the `DoorControl` function block:

```structured-text
VAR
    DoorControlFB: DoorControl; // Instantiate the DoorControl function block
    Open_Door: BOOL;             // Command to open the door
    Door_Closed: BOOL;           // Input for door closed status
    Init: BOOL;                  // Initialization input
    Ready: BOOL;                 // Indicates readiness of sequence
END_VAR
```

### Testing
1. **Simulation**: Once the function block is implemented in CODESYS, you can simulate the control sequence to check if the transitions work as expected:
    - Test the opening and closing of the door with the corresponding button press.
    - Verify that the door opens for 7 seconds and stays open for 3 seconds before closing.
    - Ensure that the sequence resets once the door is closed and is ready for the next request.

2. **PLC Hardware**: Once the simulation is successful, you can upload the program to the Lucas-Nülle PLC hardware for real-world testing.

### Conclusion
This solution provides a structured approach to implementing the door control logic using a sequence of steps with timers for delay management. The function block can be expanded or modified as needed for more complex systems.
