package Box2D.Dynamics.Joints
{
    import Box2D.Dynamics.*;

    public class b2JointDef extends Object
    {
        public var collideConnected:Boolean;
        public var body1:b2Body;
        public var body2:b2Body;
        public var userData:Object;
        public var type:int;

        public function b2JointDef()
        {
            type = b2Joint.e_unknownJoint;
            userData = null;
            body1 = null;
            body2 = null;
            collideConnected = false;
            return;
        }// end function

    }
}
