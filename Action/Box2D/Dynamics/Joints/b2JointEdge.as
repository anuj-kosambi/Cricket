package Box2D.Dynamics.Joints
{
    import Box2D.Dynamics.*;

    public class b2JointEdge extends Object
    {
        public var joint:b2Joint;
        public var other:b2Body;
        public var next:b2JointEdge;
        public var prev:b2JointEdge;

        public function b2JointEdge()
        {
            return;
        }// end function

    }
}
