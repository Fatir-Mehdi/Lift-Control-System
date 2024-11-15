# **Lift Control System Project Series**

## **README**

This repository contains a comprehensive series of six projects focused on developing a robust and scalable lift control system. Each project progressively enhances the functionality, incorporating advanced features such as emergency stop mechanisms, manual overrides, and automated door and lift controls. The final system is implemented using Lucas-Nülle PLC and the CODESYS environment.

![image](https://github.com/user-attachments/assets/43b352bd-93dc-487a-b404-ed0af40db90b)

---

## **Methodology**

The methodology adopted for this project series revolves around incremental design and modular development:

1. **Requirement Analysis**: Understanding the fundamental operations of a lift system.
2. **Incremental Implementation**: Starting with basic lift movement and progressively adding functionalities like door control, emergency stop, and manual operations.
3. **Testing and Validation**: Testing the system at each stage for real-world scenarios, ensuring reliability and compliance with safety standards.
4. **Iterative Enhancement**: Refining each stage to align with functional and safety requirements.

---

## **Tools and Resources Required**

### **Hardware**:
- Lucas-Nülle PLC
- Sensors for floor detection
- Actuators for lift and door movement
- Emergency stop buttons and manual override switches

### **Software**:
- **CODESYS**: For programming and simulation of PLC logic
- **Timers**: TON/TOF for handling delays in door operations
- **Programming Languages**: Structured Text (ST) and Ladder Diagram (LAD)
- **Visualization Tools**: Graphical tools in CODESYS for process representation

---

## **Brief Description**

This project series builds a complete lift control system, divided into six incremental projects:

1. Door control [More Detail](Door_Control_project.md)
2. Cabin control [More Detail](Cabin_Control_project.md)
3. Control of lift for two floors [More Detail](Control_of_Lift(2_Floors).md)
4. Control of lift for three floors [More Detail](Control_of_Lift(3_Floors).md)
5. Sequence with door control [More Detail](Sequence_with_Door_Control.md)
6. Full sequence required for lift [More Detail](Full_Sequence.md)

Each stage ensures safety, efficiency, and scalability of the lift system.

---

## **Steps Performed**

1. **Project Setup**:
   - Configured hardware connections.
   - Initialized inputs and outputs for lift, door, and manual/emergency controls.

2. **Programming Logic**:
   - Implemented structured text (ST) and ladder diagram (LAD) for control sequences.
   - Used timers for synchronized door and lift operations.

3. **Testing and Debugging**:
   - Validated functionality after each incremental development.
   - Simulated emergency and manual control scenarios for reliability.

4. **Documentation**:
   - Recorded findings, challenges, and resolutions for each phase.

---

## **Skills Acquired**

1. **PLC Programming**: Proficiency in structured text (ST) and ladder diagram (LAD).
2. **System Integration**: Combining hardware and software for a functional system.
3. **Safety Systems**: Designing and implementing emergency stop and interlock mechanisms.
4. **Project Management**: Incremental development and testing of modular systems.
5. **Problem-Solving**: Handling real-world challenges in automation systems.

---

## **Results**

- A fully functional and reliable lift control system with advanced safety mechanisms.
- Smooth automated operations, with manual override capabilities during emergencies.
- Timely and synchronized door and lift movements.

---

## **Importance of the Project**

- **Practical Relevance**: Simulates real-world lift systems used in residential and commercial buildings.
- **Safety Focus**: Emphasizes critical safety aspects such as emergency halting and manual operations.
- **Skill Enhancement**: Develops practical skills in PLC programming and automation.
- **Foundation for Advanced Systems**: Forms a basis for future enhancements like IoT integration or predictive maintenance.

---

## **Conclusion**

This project series successfully demonstrates the development of a lift control system from basic functionality to a sophisticated, safe, and reliable automated system. It highlights the significance of incremental design, rigorous testing, and safety compliance in industrial automation. This repository serves as a valuable resource for students and professionals interested in PLC programming and automation systems.
