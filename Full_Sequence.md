### Project 06: Full Sequence Required for Lift with Emergency Stop and Manual Operation

#### **Objective**  
Develop a complete lift control system with door control, emergency stop functionality, and manual operation capabilities. Implement the solution in the CODESYS environment for the Lucas-Nülle PLC.

---

### **Requirements**
1. **Lift Movement Control**: Based on floor requests.
2. **Door Control**: Doors open automatically when the lift stops at a floor.
3. **Emergency Stop**:
   - When the stop button is pressed, the lift stops immediately.
   - Doors remain stationary.
4. **Manual Operation**:
   - Manual override for cabin movement.
   - Manual door opening and closing during emergencies.

---

### **Structure**
The program will have:
1. **Inputs and Outputs**:
   - Inputs: Floor request buttons, position sensors, door closed sensors, emergency stop button, and manual control buttons.
   - Outputs: Motor control signals for lift movement, door movement, and indicator signals.
2. **Function Blocks**:
   - **Lift Control**: Manages lift movement between floors.
   - **Door Control**: Manages door operations at each floor.
   - **Emergency Stop and Manual Override**: Ensures safety and manual control during emergencies.

---

### **Variables**

#### **Inputs**
| Name                  | Address      | Type  | Description                             |
|-----------------------|--------------|-------|-----------------------------------------|
| `Stop_Button`         | `%IX1.0`     | BOOL  | Emergency stop button                   |
| `Manual_Move_Up`      | `%IX1.1`     | BOOL  | Manual button for lift up movement      |
| `Manual_Move_Down`    | `%IX1.2`     | BOOL  | Manual button for lift down movement    |
| `Manual_Open_Door`    | `%IX1.3`     | BOOL  | Manual button for door opening          |
| `Manual_Close_Door`   | `%IX1.4`     | BOOL  | Manual button for door closing          |
| `Floor_Request`       | `%IX1.5`     | BOOL  | Request for floors                      |

#### **Outputs**
| Name                  | Address      | Type  | Description                             |
|-----------------------|--------------|-------|-----------------------------------------|
| `Lift_Up`             | `%QX1.0`     | BOOL  | Signal to move lift up                  |
| `Lift_Down`           | `%QX1.1`     | BOOL  | Signal to move lift down                |
| `Door_Open`           | `%QX1.2`     | BOOL  | Signal to open door                     |
| `Door_Close`          | `%QX1.3`     | BOOL  | Signal to close door                    |

#### **Timers**
| Name                  | Type | Description                             |
|-----------------------|------|-----------------------------------------|
| `Door_Open_Timer`     | TON  | Timer for door to remain open           |
| `Emergency_Timer`     | TON  | Timer to pause operations during stop   |

#### **Intermediate Variables**
| Name                  | Type  | Description                             |
|-----------------------|-------|-----------------------------------------|
| `Emergency_Active`    | BOOL  | Indicates emergency stop is active      |
| `Manual_Mode`         | BOOL  | Indicates manual mode is active         |

---

### **Logic**

#### **Emergency Stop Functionality**
1. If `Stop_Button` is pressed:
   - Stop lift movement immediately.
   - Prevent door operations.
   - Activate `Emergency_Active`.
2. In `Emergency_Active` mode:
   - Allow only manual operations for the lift and doors.

#### **Manual Operation**
1. Activate manual mode via specific inputs (`Manual_Move_Up`, `Manual_Move_Down`, `Manual_Open_Door`, `Manual_Close_Door`).
2. Manual buttons bypass automatic logic for movement or door control.

#### **Normal Operation**
1. If no emergency, proceed with normal lift and door sequence.
2. Control doors automatically after the lift stops.

---

### **Code Implementation**

#### **ST (Structured Text) Code**

```pascal
PROGRAM Lift_Control
VAR
    (* Inputs *)
    Stop_Button : BOOL := %IX1.0;
    Manual_Move_Up : BOOL := %IX1.1;
    Manual_Move_Down : BOOL := %IX1.2;
    Manual_Open_Door : BOOL := %IX1.3;
    Manual_Close_Door : BOOL := %IX1.4;
    Floor_Request : BOOL := %IX1.5;

    (* Outputs *)
    Lift_Up : BOOL := %QX1.0;
    Lift_Down : BOOL := %QX1.1;
    Door_Open : BOOL := %QX1.2;
    Door_Close : BOOL := %QX1.3;

    (* Timers *)
    Door_Open_Timer : TON;
    Emergency_Timer : TON;

    (* Internal Variables *)
    Emergency_Active : BOOL := FALSE;
    Manual_Mode : BOOL := FALSE;

END_VAR

(* Emergency Stop Logic *)
IF Stop_Button THEN
    Emergency_Active := TRUE;
    Lift_Up := FALSE;
    Lift_Down := FALSE;
    Door_Open := FALSE;
    Door_Close := FALSE;
END_IF

(* Manual Mode Logic *)
IF Emergency_Active THEN
    IF Manual_Move_Up THEN
        Lift_Up := TRUE;
        Lift_Down := FALSE;
    ELSIF Manual_Move_Down THEN
        Lift_Up := FALSE;
        Lift_Down := TRUE;
    ELSE
        Lift_Up := FALSE;
        Lift_Down := FALSE;
    END_IF

    IF Manual_Open_Door THEN
        Door_Open := TRUE;
        Door_Close := FALSE;
    ELSIF Manual_Close_Door THEN
        Door_Open := FALSE;
        Door_Close := TRUE;
    ELSE
        Door_Open := FALSE;
        Door_Close := FALSE;
    END_IF
END_IF

(* Normal Operation Logic *)
IF NOT Emergency_Active THEN
    IF Floor_Request THEN
        (* Logic for floor request handling and movement *)
        (* Add logic to manage door opening/closing *)
    END_IF
END_IF
```

#### **LAD (Ladder Diagram)**  
Translate the above logic into LAD for implementation in the CODESYS Ladder Diagram editor.

---

### **Testing**
1. **Normal Operation**:
   - Test floor requests and automatic door control.
2. **Emergency Stop**:
   - Press `Stop_Button` to verify the lift halts and doors freeze.
3. **Manual Mode**:
   - Test all manual controls for lift and door operation.

---

### **Project Output**
- A fully functional lift control system with automated and manual operations.
- Emergency stop ensures safety and overrides normal operations when needed.
