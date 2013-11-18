package wck
{
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import flash.events.*;

    public class Contact extends Event
    {
        public var normalForce:Number = 0;
        public var separation:Number = 0;
        public var bias:int = 0;
        public var key:Number = 0;
        public var tangentForce:Number = 0;
        public var position:b2Vec2 = null;
        public var cp:b2ContactPoint;
        public var normal:b2Vec2 = null;
        public var shape1:b2Shape = null;
        public var shape2:b2Shape = null;

        public function Contact(param1:String, param2:b2ContactPoint, param3:int)
        {
            bias = 0;
            shape1 = null;
            shape2 = null;
            position = null;
            normal = null;
            separation = 0;
            normalForce = 0;
            tangentForce = 0;
            key = 0;
            super(param1);
            cp = param2;
            bias = param3;
            return;
        }// end function

        public function freeze() : void
        {
            shape1 = bias == 1 ? (cp.shape1) : (cp.shape2);
            shape2 = bias == 1 ? (cp.shape2) : (cp.shape1);
            normal = cp.normal.Copy();
            normal.Multiply(bias);
            position = cp.position.Copy();
            separation = cp.separation;
            key = cp.id._key;
            return;
        }// end function

        public function applyForce(param1)
        {
            var _loc_2:* = null;
            _loc_2 = normal.Copy();
            _loc_2.Multiply(-param1);
            shape1.m_body.ApplyImpulse(_loc_2, position);
            _loc_2.Multiply(-1);
            shape2.m_body.ApplyImpulse(_loc_2, position);
            return;
        }// end function

    }
}
