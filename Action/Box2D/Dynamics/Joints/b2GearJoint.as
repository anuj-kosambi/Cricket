package Box2D.Dynamics.Joints
{
    import Box2D.Common.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;

    public class b2GearJoint extends b2Joint
    {
        public var m_force:Number;
        public var m_mass:Number;
        public var m_prismatic1:b2PrismaticJoint;
        public var m_prismatic2:b2PrismaticJoint;
        public var m_ground1:b2Body;
        public var m_ground2:b2Body;
        public var m_constant:Number;
        public var m_revolute1:b2RevoluteJoint;
        public var m_revolute2:b2RevoluteJoint;
        public var m_groundAnchor1:b2Vec2;
        public var m_groundAnchor2:b2Vec2;
        public var m_localAnchor1:b2Vec2;
        public var m_localAnchor2:b2Vec2;
        public var m_ratio:Number;
        public var m_J:b2Jacobian;

        public function b2GearJoint(param1:b2GearJointDef)
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            m_groundAnchor1 = new b2Vec2();
            m_groundAnchor2 = new b2Vec2();
            m_localAnchor1 = new b2Vec2();
            m_localAnchor2 = new b2Vec2();
            m_J = new b2Jacobian();
            super(param1);
            _loc_2 = param1.joint1.m_type;
            _loc_3 = param1.joint2.m_type;
            m_revolute1 = null;
            m_prismatic1 = null;
            m_revolute2 = null;
            m_prismatic2 = null;
            m_ground1 = param1.joint1.m_body1;
            m_body1 = param1.joint1.m_body2;
            if (_loc_2 == b2Joint.e_revoluteJoint)
            {
                m_revolute1 = param1.joint1 as b2RevoluteJoint;
                m_groundAnchor1.SetV(m_revolute1.m_localAnchor1);
                m_localAnchor1.SetV(m_revolute1.m_localAnchor2);
                _loc_4 = m_revolute1.GetJointAngle();
            }
            else
            {
                m_prismatic1 = param1.joint1 as b2PrismaticJoint;
                m_groundAnchor1.SetV(m_prismatic1.m_localAnchor1);
                m_localAnchor1.SetV(m_prismatic1.m_localAnchor2);
                _loc_4 = m_prismatic1.GetJointTranslation();
            }
            m_ground2 = param1.joint2.m_body1;
            m_body2 = param1.joint2.m_body2;
            if (_loc_3 == b2Joint.e_revoluteJoint)
            {
                m_revolute2 = param1.joint2 as b2RevoluteJoint;
                m_groundAnchor2.SetV(m_revolute2.m_localAnchor1);
                m_localAnchor2.SetV(m_revolute2.m_localAnchor2);
                _loc_5 = m_revolute2.GetJointAngle();
            }
            else
            {
                m_prismatic2 = param1.joint2 as b2PrismaticJoint;
                m_groundAnchor2.SetV(m_prismatic2.m_localAnchor1);
                m_localAnchor2.SetV(m_prismatic2.m_localAnchor2);
                _loc_5 = m_prismatic2.GetJointTranslation();
            }
            m_ratio = param1.ratio;
            m_constant = _loc_4 + m_ratio * _loc_5;
            m_force = 0;
            return;
        }// end function

        override public function GetAnchor1() : b2Vec2
        {
            return m_body1.GetWorldPoint(m_localAnchor1);
        }// end function

        override public function GetAnchor2() : b2Vec2
        {
            return m_body2.GetWorldPoint(m_localAnchor2);
        }// end function

        override public function GetReactionForce() : b2Vec2
        {
            var _loc_1:* = null;
            _loc_1 = new b2Vec2(m_force * m_J.linear2.x, m_force * m_J.linear2.y);
            return _loc_1;
        }// end function

        override public function SolvePositionConstraints() : Boolean
        {
            var _loc_1:* = NaN;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            _loc_1 = 0;
            _loc_2 = m_body1;
            _loc_3 = m_body2;
            if (m_revolute1)
            {
                _loc_4 = m_revolute1.GetJointAngle();
            }
            else
            {
                _loc_4 = m_prismatic1.GetJointTranslation();
            }
            if (m_revolute2)
            {
                _loc_5 = m_revolute2.GetJointAngle();
            }
            else
            {
                _loc_5 = m_prismatic2.GetJointTranslation();
            }
            _loc_6 = m_constant - (_loc_4 + m_ratio * _loc_5);
            _loc_7 = (-m_mass) * _loc_6;
            _loc_2.m_sweep.c.x = _loc_2.m_sweep.c.x + _loc_2.m_invMass * _loc_7 * m_J.linear1.x;
            _loc_2.m_sweep.c.y = _loc_2.m_sweep.c.y + _loc_2.m_invMass * _loc_7 * m_J.linear1.y;
            _loc_2.m_sweep.a = _loc_2.m_sweep.a + _loc_2.m_invI * _loc_7 * m_J.angular1;
            _loc_3.m_sweep.c.x = _loc_3.m_sweep.c.x + _loc_3.m_invMass * _loc_7 * m_J.linear2.x;
            _loc_3.m_sweep.c.y = _loc_3.m_sweep.c.y + _loc_3.m_invMass * _loc_7 * m_J.linear2.y;
            _loc_3.m_sweep.a = _loc_3.m_sweep.a + _loc_3.m_invI * _loc_7 * m_J.angular2;
            _loc_2.SynchronizeTransform();
            _loc_3.SynchronizeTransform();
            return _loc_1 < b2Settings.b2_linearSlop;
        }// end function

        override public function InitVelocityConstraints(param1:b2TimeStep) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            _loc_2 = m_ground1;
            _loc_3 = m_ground2;
            _loc_4 = m_body1;
            _loc_5 = m_body2;
            _loc_14 = 0;
            m_J.SetZero();
            if (m_revolute1)
            {
                m_J.angular1 = -1;
                _loc_14 = _loc_14 + _loc_4.m_invI;
            }
            else
            {
                _loc_10 = _loc_2.m_xf.R;
                _loc_11 = m_prismatic1.m_localXAxis1;
                _loc_6 = _loc_10.col1.x * _loc_11.x + _loc_10.col2.x * _loc_11.y;
                _loc_7 = _loc_10.col1.y * _loc_11.x + _loc_10.col2.y * _loc_11.y;
                _loc_10 = _loc_4.m_xf.R;
                _loc_8 = m_localAnchor1.x - _loc_4.m_sweep.localCenter.x;
                _loc_9 = m_localAnchor1.y - _loc_4.m_sweep.localCenter.y;
                _loc_13 = _loc_10.col1.x * _loc_8 + _loc_10.col2.x * _loc_9;
                _loc_9 = _loc_10.col1.y * _loc_8 + _loc_10.col2.y * _loc_9;
                _loc_8 = _loc_13;
                _loc_12 = _loc_8 * _loc_7 - _loc_9 * _loc_6;
                m_J.linear1.Set(-_loc_6, -_loc_7);
                m_J.angular1 = -_loc_12;
                _loc_14 = _loc_14 + (_loc_4.m_invMass + _loc_4.m_invI * _loc_12 * _loc_12);
            }
            if (m_revolute2)
            {
                m_J.angular2 = -m_ratio;
                _loc_14 = _loc_14 + m_ratio * m_ratio * _loc_5.m_invI;
            }
            else
            {
                _loc_10 = _loc_3.m_xf.R;
                _loc_11 = m_prismatic2.m_localXAxis1;
                _loc_6 = _loc_10.col1.x * _loc_11.x + _loc_10.col2.x * _loc_11.y;
                _loc_7 = _loc_10.col1.y * _loc_11.x + _loc_10.col2.y * _loc_11.y;
                _loc_10 = _loc_5.m_xf.R;
                _loc_8 = m_localAnchor2.x - _loc_5.m_sweep.localCenter.x;
                _loc_9 = m_localAnchor2.y - _loc_5.m_sweep.localCenter.y;
                _loc_13 = _loc_10.col1.x * _loc_8 + _loc_10.col2.x * _loc_9;
                _loc_9 = _loc_10.col1.y * _loc_8 + _loc_10.col2.y * _loc_9;
                _loc_8 = _loc_13;
                _loc_12 = _loc_8 * _loc_7 - _loc_9 * _loc_6;
                m_J.linear2.Set((-m_ratio) * _loc_6, (-m_ratio) * _loc_7);
                m_J.angular2 = (-m_ratio) * _loc_12;
                _loc_14 = _loc_14 + m_ratio * m_ratio * (_loc_5.m_invMass + _loc_5.m_invI * _loc_12 * _loc_12);
            }
            m_mass = 1 / _loc_14;
            if (param1.warmStarting)
            {
                _loc_15 = param1.dt * m_force;
                _loc_4.m_linearVelocity.x = _loc_4.m_linearVelocity.x + _loc_4.m_invMass * _loc_15 * m_J.linear1.x;
                _loc_4.m_linearVelocity.y = _loc_4.m_linearVelocity.y + _loc_4.m_invMass * _loc_15 * m_J.linear1.y;
                _loc_4.m_angularVelocity = _loc_4.m_angularVelocity + _loc_4.m_invI * _loc_15 * m_J.angular1;
                _loc_5.m_linearVelocity.x = _loc_5.m_linearVelocity.x + _loc_5.m_invMass * _loc_15 * m_J.linear2.x;
                _loc_5.m_linearVelocity.y = _loc_5.m_linearVelocity.y + _loc_5.m_invMass * _loc_15 * m_J.linear2.y;
                _loc_5.m_angularVelocity = _loc_5.m_angularVelocity + _loc_5.m_invI * _loc_15 * m_J.angular2;
            }
            else
            {
                m_force = 0;
            }
            return;
        }// end function

        override public function GetReactionTorque() : Number
        {
            var _loc_1:* = null;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            _loc_1 = m_body2.m_xf.R;
            _loc_2 = m_localAnchor1.x - m_body2.m_sweep.localCenter.x;
            _loc_3 = m_localAnchor1.y - m_body2.m_sweep.localCenter.y;
            _loc_4 = _loc_1.col1.x * _loc_2 + _loc_1.col2.x * _loc_3;
            _loc_3 = _loc_1.col1.y * _loc_2 + _loc_1.col2.y * _loc_3;
            _loc_2 = _loc_4;
            _loc_4 = m_force * m_J.angular2 - (_loc_2 * (m_force * m_J.linear2.y) - _loc_3 * (m_force * m_J.linear2.x));
            return _loc_4;
        }// end function

        public function GetRatio() : Number
        {
            return m_ratio;
        }// end function

        override public function SolveVelocityConstraints(param1:b2TimeStep) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            _loc_2 = m_body1;
            _loc_3 = m_body2;
            _loc_4 = m_J.Compute(_loc_2.m_linearVelocity, _loc_2.m_angularVelocity, _loc_3.m_linearVelocity, _loc_3.m_angularVelocity);
            _loc_5 = (-param1.inv_dt) * m_mass * _loc_4;
            m_force = m_force + _loc_5;
            _loc_6 = param1.dt * _loc_5;
            _loc_2.m_linearVelocity.x = _loc_2.m_linearVelocity.x + _loc_2.m_invMass * _loc_6 * m_J.linear1.x;
            _loc_2.m_linearVelocity.y = _loc_2.m_linearVelocity.y + _loc_2.m_invMass * _loc_6 * m_J.linear1.y;
            _loc_2.m_angularVelocity = _loc_2.m_angularVelocity + _loc_2.m_invI * _loc_6 * m_J.angular1;
            _loc_3.m_linearVelocity.x = _loc_3.m_linearVelocity.x + _loc_3.m_invMass * _loc_6 * m_J.linear2.x;
            _loc_3.m_linearVelocity.y = _loc_3.m_linearVelocity.y + _loc_3.m_invMass * _loc_6 * m_J.linear2.y;
            _loc_3.m_angularVelocity = _loc_3.m_angularVelocity + _loc_3.m_invI * _loc_6 * m_J.angular2;
            return;
        }// end function

    }
}
