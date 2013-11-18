package Box2D.Dynamics.Joints
{
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;

    public class b2Joint extends Object
    {
        public var m_islandFlag:Boolean;
        public var m_body1:b2Body;
        public var m_prev:b2Joint;
        public var m_next:b2Joint;
        public var m_type:int;
        public var m_collideConnected:Boolean;
        public var m_node1:b2JointEdge;
        public var m_node2:b2JointEdge;
        public var m_inv_dt:Number;
        public var m_userData:Object;
        public var m_body2:b2Body;
        public static const e_unknownJoint:int = 0;
        public static const e_inactiveLimit:int = 0;
        public static const e_atUpperLimit:int = 2;
        public static const e_atLowerLimit:int = 1;
        public static const e_gearJoint:int = 6;
        public static const e_revoluteJoint:int = 1;
        public static const e_equalLimits:int = 3;
        public static const e_distanceJoint:int = 3;
        public static const e_pulleyJoint:int = 4;
        public static const e_prismaticJoint:int = 2;
        public static const e_mouseJoint:int = 5;

        public function b2Joint(param1:b2JointDef)
        {
            m_node1 = new b2JointEdge();
            m_node2 = new b2JointEdge();
            m_type = param1.type;
            m_prev = null;
            m_next = null;
            m_body1 = param1.body1;
            m_body2 = param1.body2;
            m_collideConnected = param1.collideConnected;
            m_islandFlag = false;
            m_userData = param1.userData;
            return;
        }// end function

        public function GetAnchor1() : b2Vec2
        {
            return null;
        }// end function

        public function GetAnchor2() : b2Vec2
        {
            return null;
        }// end function

        public function InitVelocityConstraints(param1:b2TimeStep) : void
        {
            return;
        }// end function

        public function GetType() : int
        {
            return m_type;
        }// end function

        public function GetBody2() : b2Body
        {
            return m_body2;
        }// end function

        public function GetNext() : b2Joint
        {
            return m_next;
        }// end function

        public function GetReactionTorque() : Number
        {
            return 0;
        }// end function

        public function GetUserData()
        {
            return m_userData;
        }// end function

        public function GetReactionForce() : b2Vec2
        {
            return null;
        }// end function

        public function SolvePositionConstraints() : Boolean
        {
            return false;
        }// end function

        public function SetUserData(param1) : void
        {
            m_userData = param1;
            return;
        }// end function

        public function GetBody1() : b2Body
        {
            return m_body1;
        }// end function

        public function SolveVelocityConstraints(param1:b2TimeStep) : void
        {
            return;
        }// end function

        public function InitPositionConstraints() : void
        {
            return;
        }// end function

        public static function Destroy(param1:b2Joint, param2) : void
        {
            return;
        }// end function

        public static function Create(param1:b2JointDef, param2) : b2Joint
        {
            var _loc_3:* = null;
            _loc_3 = null;
            switch(param1.type)
            {
                case e_distanceJoint:
                {
                    _loc_3 = new b2DistanceJoint(param1 as b2DistanceJointDef);
                    break;
                }
                case e_mouseJoint:
                {
                    _loc_3 = new b2MouseJoint(param1 as b2MouseJointDef);
                    break;
                }
                case e_prismaticJoint:
                {
                    _loc_3 = new b2PrismaticJoint(param1 as b2PrismaticJointDef);
                    break;
                }
                case e_revoluteJoint:
                {
                    _loc_3 = new b2RevoluteJoint(param1 as b2RevoluteJointDef);
                    break;
                }
                case e_pulleyJoint:
                {
                    _loc_3 = new b2PulleyJoint(param1 as b2PulleyJointDef);
                    break;
                }
                case e_gearJoint:
                {
                    _loc_3 = new b2GearJoint(param1 as b2GearJointDef);
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return _loc_3;
        }// end function

    }
}
