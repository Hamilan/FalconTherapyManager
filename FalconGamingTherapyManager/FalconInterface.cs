using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace FalconGamingTherapyManager
{
    class FalconInterface
    {
        const string falconUnityWrapperPath = "FalconUnityWrapper.dll";

        // Imports.

        [DllImport(falconUnityWrapperPath)]
        public static extern bool StartHaptics();
        [DllImport(falconUnityWrapperPath)]
        public static extern void StopHaptics();

        [DllImport(falconUnityWrapperPath)]
        public static extern bool IsDeviceCalibrated();
        [DllImport(falconUnityWrapperPath)]
        public static extern bool IsDeviceReady();

        [DllImport(falconUnityWrapperPath)]
        public static extern double GetXPos();
        [DllImport(falconUnityWrapperPath)]
        public static extern double GetYPos();
        [DllImport(falconUnityWrapperPath)]
        public static extern double GetZPos();

        [DllImport(falconUnityWrapperPath)]
        public static extern void SetServo(double[] force);
        [DllImport(falconUnityWrapperPath)]
        public static extern void SetServoPos(double[] pos, double force);
        [DllImport(falconUnityWrapperPath)]
        public static extern void HoldServoPos(bool enable);
        [DllImport(falconUnityWrapperPath, CallingConvention = CallingConvention.Cdecl)]
        public static extern void StartSpring(double k);
        [DllImport(falconUnityWrapperPath)]
        public static extern void StopSpring();
        [DllImport(falconUnityWrapperPath)]
        public static extern void StartImpact(float maxForce, float holdTime, float decayTime);
        [DllImport(falconUnityWrapperPath, CallingConvention = CallingConvention.Cdecl)]
        public static extern void SetWeight(float mass);
        [DllImport(falconUnityWrapperPath)]
        public static extern void StopWeight();
        [DllImport(falconUnityWrapperPath)]
        public static extern void SetProportionalWeight(float mass);
        [DllImport(falconUnityWrapperPath)]
        public static extern void StopProportionalWeight();
        [DllImport(falconUnityWrapperPath)]
        public static extern void StartVibrate();
        [DllImport(falconUnityWrapperPath)]
        public static extern void StopVibrate();
        [DllImport(falconUnityWrapperPath, CallingConvention = CallingConvention.Cdecl)]
        public static extern void StartRadialResist(float force);
        [DllImport(falconUnityWrapperPath)]
        public static extern void StopRadialResist();

        [DllImport(falconUnityWrapperPath)]
        public static extern bool IsHapticButtonDepressed();
        [DllImport(falconUnityWrapperPath)]
        public static extern int GetButtonsDown();
        [DllImport(falconUnityWrapperPath)]
        public static extern bool isButton0Down();
        [DllImport(falconUnityWrapperPath)]
        public static extern bool isButton1Down();
        [DllImport(falconUnityWrapperPath)]
        public static extern bool isButton2Down();
        [DllImport(falconUnityWrapperPath)]
        public static extern bool isButton3Down();
    }
}
