package Box2D.Dynamics.Joints
{
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;

    public class b2DistanceJointDef extends b2JointDef
    {
        public var length:Number;
        public var dampingRatio:Number;
        public var frequencyHz:Number;
        public var localAnchor2:b2Vec2;
        public var localAnchor1:b2Vec2;

        public function b2DistanceJointDef()
        {
            localAnchor1 = new b2Vec2();
            localAnchor2 = new b2Vec2();
            type = b2Joint.e_distanceJoint;
            length = 1;
            frequencyHz = 0;
            dampingRatio = 0;
            return;
        }// end function

        public function Initialize(param1:b2Body, param2:b2Body, param3:b2Vec2, param4:b2Vec2) : void
        {
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            body1 = param1;
            body2 = param2;
            localAnchor1.SetV(body1.GetLocalPoint(param3));
            localAnchor2.SetV(body2.GetLocalPoint(param4));
            _loc_5 = param4.x - param3.x;
            _loc_6 = param4.y - param3.y;
            length = Math.sqrt(_loc_5 * _loc_5 + _loc_6 * _loc_6);
            frequencyHz = 0;
            dampingRatio = 0;
            return;
        }// end function

    }
}
