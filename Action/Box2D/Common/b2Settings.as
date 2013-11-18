package Box2D.Common
{
    import Box2D.Common.Math.*;

    public class b2Settings extends Object
    {
        public static const b2_angularSleepTolerance:Number = 0.0111111;
        public static const b2_linearSleepTolerance:Number = 0.01;
        public static const b2_angularSlop:Number = 0.0349066;
        public static const b2_linearSlop:Number = 0.005;
        public static const b2_pi:Number = 3.14159;
        public static const b2_maxProxies:int = 512;
        public static const b2_maxAngularVelocitySquared:Number = 62500;
        public static const b2_maxPolygonVertices:int = 8;
        public static const b2_velocityThreshold:Number = 1;
        public static const b2_contactBaumgarte:Number = 0.2;
        public static const b2_maxPairs:int = 4096;
        public static const b2_maxTOIContactsPerIsland:int = 32;
        public static const b2_timeToSleep:Number = 0.5;
        public static const b2_maxManifoldPoints:int = 2;
        public static const b2_maxAngularVelocity:Number = 250;
        public static const b2_maxAngularCorrection:Number = 0.139626;
        public static const USHRT_MAX:int = 65535;
        public static const b2_maxLinearVelocity:Number = 200;
        public static const b2_maxLinearCorrection:Number = 0.2;
        public static const b2_toiSlop:Number = 0.04;
        public static const b2_maxLinearVelocitySquared:Number = 40000;

        public function b2Settings()
        {
            return;
        }// end function

        public static function b2Assert(param1:Boolean) : void
        {
            var _loc_2:* = null;
            if (!param1)
            {
                var _loc_3:* = _loc_2;
                var _loc_4:* = _loc_2.x + 1;
                _loc_3.x = _loc_4;
            }
            return;
        }// end function

    }
}
