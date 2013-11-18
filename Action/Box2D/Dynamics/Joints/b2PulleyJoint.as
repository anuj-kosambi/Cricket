package Box2D.Dynamics.Joints
{
    import Box2D.Common.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;

    public class b2PulleyJoint extends b2Joint
    {
        public var m_ground:b2Body;
        public var m_maxLength2:Number;
        public var m_limitForce1:Number;
        public var m_maxLength1:Number;
        public var m_limitState1:int;
        public var m_limitState2:int;
        public var m_limitPositionImpulse2:Number;
        public var m_force:Number;
        public var m_limitPositionImpulse1:Number;
        public var m_constant:Number;
        public var m_state:int;
        public var m_ratio:Number;
        public var m_groundAnchor1:b2Vec2;
        public var m_groundAnchor2:b2Vec2;
        public var m_localAnchor1:b2Vec2;
        public var m_localAnchor2:b2Vec2;
        public var m_positionImpulse:Number;
        public var m_limitMass2:Number;
        public var m_limitMass1:Number;
        public var m_pulleyMass:Number;
        public var m_u1:b2Vec2;
        public var m_u2:b2Vec2;
        public var m_limitForce2:Number;
        public static const b2_minPulleyLength:Number = 2;

        public function b2PulleyJoint(param1:b2PulleyJointDef)
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            m_groundAnchor1 = new b2Vec2();
            m_groundAnchor2 = new b2Vec2();
            m_localAnchor1 = new b2Vec2();
            m_localAnchor2 = new b2Vec2();
            m_u1 = new b2Vec2();
            m_u2 = new b2Vec2();
            super(param1);
            m_ground = m_body1.m_world.m_groundBody;
            m_groundAnchor1.x = param1.groundAnchor1.x - m_ground.m_xf.position.x;
            m_groundAnchor1.y = param1.groundAnchor1.y - m_ground.m_xf.position.y;
            m_groundAnchor2.x = param1.groundAnchor2.x - m_ground.m_xf.position.x;
            m_groundAnchor2.y = param1.groundAnchor2.y - m_ground.m_xf.position.y;
            m_localAnchor1.SetV(param1.localAnchor1);
            m_localAnchor2.SetV(param1.localAnchor2);
            m_ratio = param1.ratio;
            m_constant = param1.length1 + m_ratio * param1.length2;
            m_maxLength1 = b2Math.b2Min(param1.maxLength1, m_constant - m_ratio * b2_minPulleyLength);
            m_maxLength2 = b2Math.b2Min(param1.maxLength2, (m_constant - b2_minPulleyLength) / m_ratio);
            m_force = 0;
            m_limitForce1 = 0;
            m_limitForce2 = 0;
            return;
        }// end function

        public function GetGroundAnchor2() : b2Vec2
        {
            var _loc_1:* = null;
            _loc_1 = m_ground.m_xf.position.Copy();
            _loc_1.Add(m_groundAnchor2);
            return _loc_1;
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
            _loc_1 = m_u2.Copy();
            _loc_1.Multiply(m_force);
            return _loc_1;
        }// end function

        override public function SolvePositionConstraints() : Boolean
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            _loc_1 = m_body1;
            _loc_2 = m_body2;
            _loc_4 = m_ground.m_xf.position.x + m_groundAnchor1.x;
            _loc_5 = m_ground.m_xf.position.y + m_groundAnchor1.y;
            _loc_6 = m_ground.m_xf.position.x + m_groundAnchor2.x;
            _loc_7 = m_ground.m_xf.position.y + m_groundAnchor2.y;
            _loc_23 = 0;
            if (m_state == e_atUpperLimit)
            {
                _loc_3 = _loc_1.m_xf.R;
                _loc_8 = m_localAnchor1.x - _loc_1.m_sweep.localCenter.x;
                _loc_9 = m_localAnchor1.y - _loc_1.m_sweep.localCenter.y;
                _loc_22 = _loc_3.col1.x * _loc_8 + _loc_3.col2.x * _loc_9;
                _loc_9 = _loc_3.col1.y * _loc_8 + _loc_3.col2.y * _loc_9;
                _loc_8 = _loc_22;
                _loc_3 = _loc_2.m_xf.R;
                _loc_10 = m_localAnchor2.x - _loc_2.m_sweep.localCenter.x;
                _loc_11 = m_localAnchor2.y - _loc_2.m_sweep.localCenter.y;
                _loc_22 = _loc_3.col1.x * _loc_10 + _loc_3.col2.x * _loc_11;
                _loc_11 = _loc_3.col1.y * _loc_10 + _loc_3.col2.y * _loc_11;
                _loc_10 = _loc_22;
                _loc_12 = _loc_1.m_sweep.c.x + _loc_8;
                _loc_13 = _loc_1.m_sweep.c.y + _loc_9;
                _loc_14 = _loc_2.m_sweep.c.x + _loc_10;
                _loc_15 = _loc_2.m_sweep.c.y + _loc_11;
                m_u1.Set(_loc_12 - _loc_4, _loc_13 - _loc_5);
                m_u2.Set(_loc_14 - _loc_6, _loc_15 - _loc_7);
                _loc_16 = m_u1.Length();
                _loc_17 = m_u2.Length();
                if (_loc_16 > b2Settings.b2_linearSlop)
                {
                    m_u1.Multiply(1 / _loc_16);
                }
                else
                {
                    m_u1.SetZero();
                }
                if (_loc_17 > b2Settings.b2_linearSlop)
                {
                    m_u2.Multiply(1 / _loc_17);
                }
                else
                {
                    m_u2.SetZero();
                }
                _loc_18 = m_constant - _loc_16 - m_ratio * _loc_17;
                _loc_23 = b2Math.b2Max(_loc_23, -_loc_18);
                _loc_18 = b2Math.b2Clamp(_loc_18 + b2Settings.b2_linearSlop, -b2Settings.b2_maxLinearCorrection, 0);
                _loc_19 = (-m_pulleyMass) * _loc_18;
                _loc_20 = m_positionImpulse;
                m_positionImpulse = b2Math.b2Max(0, m_positionImpulse + _loc_19);
                _loc_19 = m_positionImpulse - _loc_20;
                _loc_12 = (-_loc_19) * m_u1.x;
                _loc_13 = (-_loc_19) * m_u1.y;
                _loc_14 = (-m_ratio) * _loc_19 * m_u2.x;
                _loc_15 = (-m_ratio) * _loc_19 * m_u2.y;
                _loc_1.m_sweep.c.x = _loc_1.m_sweep.c.x + _loc_1.m_invMass * _loc_12;
                _loc_1.m_sweep.c.y = _loc_1.m_sweep.c.y + _loc_1.m_invMass * _loc_13;
                _loc_1.m_sweep.a = _loc_1.m_sweep.a + _loc_1.m_invI * (_loc_8 * _loc_13 - _loc_9 * _loc_12);
                _loc_2.m_sweep.c.x = _loc_2.m_sweep.c.x + _loc_2.m_invMass * _loc_14;
                _loc_2.m_sweep.c.y = _loc_2.m_sweep.c.y + _loc_2.m_invMass * _loc_15;
                _loc_2.m_sweep.a = _loc_2.m_sweep.a + _loc_2.m_invI * (_loc_10 * _loc_15 - _loc_11 * _loc_14);
                _loc_1.SynchronizeTransform();
                _loc_2.SynchronizeTransform();
            }
            if (m_limitState1 == e_atUpperLimit)
            {
                _loc_3 = _loc_1.m_xf.R;
                _loc_8 = m_localAnchor1.x - _loc_1.m_sweep.localCenter.x;
                _loc_9 = m_localAnchor1.y - _loc_1.m_sweep.localCenter.y;
                _loc_22 = _loc_3.col1.x * _loc_8 + _loc_3.col2.x * _loc_9;
                _loc_9 = _loc_3.col1.y * _loc_8 + _loc_3.col2.y * _loc_9;
                _loc_8 = _loc_22;
                _loc_12 = _loc_1.m_sweep.c.x + _loc_8;
                _loc_13 = _loc_1.m_sweep.c.y + _loc_9;
                m_u1.Set(_loc_12 - _loc_4, _loc_13 - _loc_5);
                _loc_16 = m_u1.Length();
                if (_loc_16 > b2Settings.b2_linearSlop)
                {
                    m_u1.x = m_u1.x * (1 / _loc_16);
                    m_u1.y = m_u1.y * (1 / _loc_16);
                }
                else
                {
                    m_u1.SetZero();
                }
                _loc_18 = m_maxLength1 - _loc_16;
                _loc_23 = b2Math.b2Max(_loc_23, -_loc_18);
                _loc_18 = b2Math.b2Clamp(_loc_18 + b2Settings.b2_linearSlop, -b2Settings.b2_maxLinearCorrection, 0);
                _loc_19 = (-m_limitMass1) * _loc_18;
                _loc_21 = m_limitPositionImpulse1;
                m_limitPositionImpulse1 = b2Math.b2Max(0, m_limitPositionImpulse1 + _loc_19);
                _loc_19 = m_limitPositionImpulse1 - _loc_21;
                _loc_12 = (-_loc_19) * m_u1.x;
                _loc_13 = (-_loc_19) * m_u1.y;
                _loc_1.m_sweep.c.x = _loc_1.m_sweep.c.x + _loc_1.m_invMass * _loc_12;
                _loc_1.m_sweep.c.y = _loc_1.m_sweep.c.y + _loc_1.m_invMass * _loc_13;
                _loc_1.m_sweep.a = _loc_1.m_sweep.a + _loc_1.m_invI * (_loc_8 * _loc_13 - _loc_9 * _loc_12);
                _loc_1.SynchronizeTransform();
            }
            if (m_limitState2 == e_atUpperLimit)
            {
                _loc_3 = _loc_2.m_xf.R;
                _loc_10 = m_localAnchor2.x - _loc_2.m_sweep.localCenter.x;
                _loc_11 = m_localAnchor2.y - _loc_2.m_sweep.localCenter.y;
                _loc_22 = _loc_3.col1.x * _loc_10 + _loc_3.col2.x * _loc_11;
                _loc_11 = _loc_3.col1.y * _loc_10 + _loc_3.col2.y * _loc_11;
                _loc_10 = _loc_22;
                _loc_14 = _loc_2.m_sweep.c.x + _loc_10;
                _loc_15 = _loc_2.m_sweep.c.y + _loc_11;
                m_u2.Set(_loc_14 - _loc_6, _loc_15 - _loc_7);
                _loc_17 = m_u2.Length();
                if (_loc_17 > b2Settings.b2_linearSlop)
                {
                    m_u2.x = m_u2.x * (1 / _loc_17);
                    m_u2.y = m_u2.y * (1 / _loc_17);
                }
                else
                {
                    m_u2.SetZero();
                }
                _loc_18 = m_maxLength2 - _loc_17;
                _loc_23 = b2Math.b2Max(_loc_23, -_loc_18);
                _loc_18 = b2Math.b2Clamp(_loc_18 + b2Settings.b2_linearSlop, -b2Settings.b2_maxLinearCorrection, 0);
                _loc_19 = (-m_limitMass2) * _loc_18;
                _loc_21 = m_limitPositionImpulse2;
                m_limitPositionImpulse2 = b2Math.b2Max(0, m_limitPositionImpulse2 + _loc_19);
                _loc_19 = m_limitPositionImpulse2 - _loc_21;
                _loc_14 = (-_loc_19) * m_u2.x;
                _loc_15 = (-_loc_19) * m_u2.y;
                _loc_2.m_sweep.c.x = _loc_2.m_sweep.c.x + _loc_2.m_invMass * _loc_14;
                _loc_2.m_sweep.c.y = _loc_2.m_sweep.c.y + _loc_2.m_invMass * _loc_15;
                _loc_2.m_sweep.a = _loc_2.m_sweep.a + _loc_2.m_invI * (_loc_10 * _loc_15 - _loc_11 * _loc_14);
                _loc_2.SynchronizeTransform();
            }
            return _loc_23 < b2Settings.b2_linearSlop;
        }// end function

        override public function InitVelocityConstraints(param1:b2TimeStep) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            var _loc_26:* = NaN;
            _loc_2 = m_body1;
            _loc_3 = m_body2;
            _loc_4 = _loc_2.m_xf.R;
            _loc_5 = m_localAnchor1.x - _loc_2.m_sweep.localCenter.x;
            _loc_6 = m_localAnchor1.y - _loc_2.m_sweep.localCenter.y;
            _loc_7 = _loc_4.col1.x * _loc_5 + _loc_4.col2.x * _loc_6;
            _loc_6 = _loc_4.col1.y * _loc_5 + _loc_4.col2.y * _loc_6;
            _loc_5 = _loc_7;
            _loc_4 = _loc_3.m_xf.R;
            _loc_8 = m_localAnchor2.x - _loc_3.m_sweep.localCenter.x;
            _loc_9 = m_localAnchor2.y - _loc_3.m_sweep.localCenter.y;
            _loc_7 = _loc_4.col1.x * _loc_8 + _loc_4.col2.x * _loc_9;
            _loc_9 = _loc_4.col1.y * _loc_8 + _loc_4.col2.y * _loc_9;
            _loc_8 = _loc_7;
            _loc_10 = _loc_2.m_sweep.c.x + _loc_5;
            _loc_11 = _loc_2.m_sweep.c.y + _loc_6;
            _loc_12 = _loc_3.m_sweep.c.x + _loc_8;
            _loc_13 = _loc_3.m_sweep.c.y + _loc_9;
            _loc_14 = m_ground.m_xf.position.x + m_groundAnchor1.x;
            _loc_15 = m_ground.m_xf.position.y + m_groundAnchor1.y;
            _loc_16 = m_ground.m_xf.position.x + m_groundAnchor2.x;
            _loc_17 = m_ground.m_xf.position.y + m_groundAnchor2.y;
            m_u1.Set(_loc_10 - _loc_14, _loc_11 - _loc_15);
            m_u2.Set(_loc_12 - _loc_16, _loc_13 - _loc_17);
            _loc_18 = m_u1.Length();
            _loc_19 = m_u2.Length();
            if (_loc_18 > b2Settings.b2_linearSlop)
            {
                m_u1.Multiply(1 / _loc_18);
            }
            else
            {
                m_u1.SetZero();
            }
            if (_loc_19 > b2Settings.b2_linearSlop)
            {
                m_u2.Multiply(1 / _loc_19);
            }
            else
            {
                m_u2.SetZero();
            }
            _loc_20 = m_constant - _loc_18 - m_ratio * _loc_19;
            if (_loc_20 > 0)
            {
                m_state = e_inactiveLimit;
                m_force = 0;
            }
            else
            {
                m_state = e_atUpperLimit;
                m_positionImpulse = 0;
            }
            if (_loc_18 < m_maxLength1)
            {
                m_limitState1 = e_inactiveLimit;
                m_limitForce1 = 0;
            }
            else
            {
                m_limitState1 = e_atUpperLimit;
                m_limitPositionImpulse1 = 0;
            }
            if (_loc_19 < m_maxLength2)
            {
                m_limitState2 = e_inactiveLimit;
                m_limitForce2 = 0;
            }
            else
            {
                m_limitState2 = e_atUpperLimit;
                m_limitPositionImpulse2 = 0;
            }
            _loc_21 = _loc_5 * m_u1.y - _loc_6 * m_u1.x;
            _loc_22 = _loc_8 * m_u2.y - _loc_9 * m_u2.x;
            m_limitMass1 = _loc_2.m_invMass + _loc_2.m_invI * _loc_21 * _loc_21;
            m_limitMass2 = _loc_3.m_invMass + _loc_3.m_invI * _loc_22 * _loc_22;
            m_pulleyMass = m_limitMass1 + m_ratio * m_ratio * m_limitMass2;
            m_limitMass1 = 1 / m_limitMass1;
            m_limitMass2 = 1 / m_limitMass2;
            m_pulleyMass = 1 / m_pulleyMass;
            if (param1.warmStarting)
            {
                _loc_23 = param1.dt * (-m_force - m_limitForce1) * m_u1.x;
                _loc_24 = param1.dt * (-m_force - m_limitForce1) * m_u1.y;
                _loc_25 = param1.dt * ((-m_ratio) * m_force - m_limitForce2) * m_u2.x;
                _loc_26 = param1.dt * ((-m_ratio) * m_force - m_limitForce2) * m_u2.y;
                _loc_2.m_linearVelocity.x = _loc_2.m_linearVelocity.x + _loc_2.m_invMass * _loc_23;
                _loc_2.m_linearVelocity.y = _loc_2.m_linearVelocity.y + _loc_2.m_invMass * _loc_24;
                _loc_2.m_angularVelocity = _loc_2.m_angularVelocity + _loc_2.m_invI * (_loc_5 * _loc_24 - _loc_6 * _loc_23);
                _loc_3.m_linearVelocity.x = _loc_3.m_linearVelocity.x + _loc_3.m_invMass * _loc_25;
                _loc_3.m_linearVelocity.y = _loc_3.m_linearVelocity.y + _loc_3.m_invMass * _loc_26;
                _loc_3.m_angularVelocity = _loc_3.m_angularVelocity + _loc_3.m_invI * (_loc_8 * _loc_26 - _loc_9 * _loc_25);
            }
            else
            {
                m_force = 0;
                m_limitForce1 = 0;
                m_limitForce2 = 0;
            }
            return;
        }// end function

        override public function GetReactionTorque() : Number
        {
            return 0;
        }// end function

        public function GetRatio() : Number
        {
            return m_ratio;
        }// end function

        public function GetLength2() : Number
        {
            var _loc_1:* = null;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            _loc_1 = m_body2.GetWorldPoint(m_localAnchor2);
            _loc_2 = m_ground.m_xf.position.x + m_groundAnchor2.x;
            _loc_3 = m_ground.m_xf.position.y + m_groundAnchor2.y;
            _loc_4 = _loc_1.x - _loc_2;
            _loc_5 = _loc_1.y - _loc_3;
            return Math.sqrt(_loc_4 * _loc_4 + _loc_5 * _loc_5);
        }// end function

        override public function SolveVelocityConstraints(param1:b2TimeStep) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            _loc_2 = m_body1;
            _loc_3 = m_body2;
            _loc_4 = _loc_2.m_xf.R;
            _loc_5 = m_localAnchor1.x - _loc_2.m_sweep.localCenter.x;
            _loc_6 = m_localAnchor1.y - _loc_2.m_sweep.localCenter.y;
            _loc_7 = _loc_4.col1.x * _loc_5 + _loc_4.col2.x * _loc_6;
            _loc_6 = _loc_4.col1.y * _loc_5 + _loc_4.col2.y * _loc_6;
            _loc_5 = _loc_7;
            _loc_4 = _loc_3.m_xf.R;
            _loc_8 = m_localAnchor2.x - _loc_3.m_sweep.localCenter.x;
            _loc_9 = m_localAnchor2.y - _loc_3.m_sweep.localCenter.y;
            _loc_7 = _loc_4.col1.x * _loc_8 + _loc_4.col2.x * _loc_9;
            _loc_9 = _loc_4.col1.y * _loc_8 + _loc_4.col2.y * _loc_9;
            _loc_8 = _loc_7;
            if (m_state == e_atUpperLimit)
            {
                _loc_10 = _loc_2.m_linearVelocity.x + (-_loc_2.m_angularVelocity) * _loc_6;
                _loc_11 = _loc_2.m_linearVelocity.y + _loc_2.m_angularVelocity * _loc_5;
                _loc_12 = _loc_3.m_linearVelocity.x + (-_loc_3.m_angularVelocity) * _loc_9;
                _loc_13 = _loc_3.m_linearVelocity.y + _loc_3.m_angularVelocity * _loc_8;
                _loc_18 = -(m_u1.x * _loc_10 + m_u1.y * _loc_11) - m_ratio * (m_u2.x * _loc_12 + m_u2.y * _loc_13);
                _loc_19 = (-param1.inv_dt) * m_pulleyMass * _loc_18;
                _loc_20 = m_force;
                m_force = b2Math.b2Max(0, m_force + _loc_19);
                _loc_19 = m_force - _loc_20;
                _loc_14 = (-param1.dt) * _loc_19 * m_u1.x;
                _loc_15 = (-param1.dt) * _loc_19 * m_u1.y;
                _loc_16 = (-param1.dt) * m_ratio * _loc_19 * m_u2.x;
                _loc_17 = (-param1.dt) * m_ratio * _loc_19 * m_u2.y;
                _loc_2.m_linearVelocity.x = _loc_2.m_linearVelocity.x + _loc_2.m_invMass * _loc_14;
                _loc_2.m_linearVelocity.y = _loc_2.m_linearVelocity.y + _loc_2.m_invMass * _loc_15;
                _loc_2.m_angularVelocity = _loc_2.m_angularVelocity + _loc_2.m_invI * (_loc_5 * _loc_15 - _loc_6 * _loc_14);
                _loc_3.m_linearVelocity.x = _loc_3.m_linearVelocity.x + _loc_3.m_invMass * _loc_16;
                _loc_3.m_linearVelocity.y = _loc_3.m_linearVelocity.y + _loc_3.m_invMass * _loc_17;
                _loc_3.m_angularVelocity = _loc_3.m_angularVelocity + _loc_3.m_invI * (_loc_8 * _loc_17 - _loc_9 * _loc_16);
            }
            if (m_limitState1 == e_atUpperLimit)
            {
                _loc_10 = _loc_2.m_linearVelocity.x + (-_loc_2.m_angularVelocity) * _loc_6;
                _loc_11 = _loc_2.m_linearVelocity.y + _loc_2.m_angularVelocity * _loc_5;
                _loc_18 = -(m_u1.x * _loc_10 + m_u1.y * _loc_11);
                _loc_19 = (-param1.inv_dt) * m_limitMass1 * _loc_18;
                _loc_20 = m_limitForce1;
                m_limitForce1 = b2Math.b2Max(0, m_limitForce1 + _loc_19);
                _loc_19 = m_limitForce1 - _loc_20;
                _loc_14 = (-param1.dt) * _loc_19 * m_u1.x;
                _loc_15 = (-param1.dt) * _loc_19 * m_u1.y;
                _loc_2.m_linearVelocity.x = _loc_2.m_linearVelocity.x + _loc_2.m_invMass * _loc_14;
                _loc_2.m_linearVelocity.y = _loc_2.m_linearVelocity.y + _loc_2.m_invMass * _loc_15;
                _loc_2.m_angularVelocity = _loc_2.m_angularVelocity + _loc_2.m_invI * (_loc_5 * _loc_15 - _loc_6 * _loc_14);
            }
            if (m_limitState2 == e_atUpperLimit)
            {
                _loc_12 = _loc_3.m_linearVelocity.x + (-_loc_3.m_angularVelocity) * _loc_9;
                _loc_13 = _loc_3.m_linearVelocity.y + _loc_3.m_angularVelocity * _loc_8;
                _loc_18 = -(m_u2.x * _loc_12 + m_u2.y * _loc_13);
                _loc_19 = (-param1.inv_dt) * m_limitMass2 * _loc_18;
                _loc_20 = m_limitForce2;
                m_limitForce2 = b2Math.b2Max(0, m_limitForce2 + _loc_19);
                _loc_19 = m_limitForce2 - _loc_20;
                _loc_16 = (-param1.dt) * _loc_19 * m_u2.x;
                _loc_17 = (-param1.dt) * _loc_19 * m_u2.y;
                _loc_3.m_linearVelocity.x = _loc_3.m_linearVelocity.x + _loc_3.m_invMass * _loc_16;
                _loc_3.m_linearVelocity.y = _loc_3.m_linearVelocity.y + _loc_3.m_invMass * _loc_17;
                _loc_3.m_angularVelocity = _loc_3.m_angularVelocity + _loc_3.m_invI * (_loc_8 * _loc_17 - _loc_9 * _loc_16);
            }
            return;
        }// end function

        public function GetLength1() : Number
        {
            var _loc_1:* = null;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            _loc_1 = m_body1.GetWorldPoint(m_localAnchor1);
            _loc_2 = m_ground.m_xf.position.x + m_groundAnchor1.x;
            _loc_3 = m_ground.m_xf.position.y + m_groundAnchor1.y;
            _loc_4 = _loc_1.x - _loc_2;
            _loc_5 = _loc_1.y - _loc_3;
            return Math.sqrt(_loc_4 * _loc_4 + _loc_5 * _loc_5);
        }// end function

        public function GetGroundAnchor1() : b2Vec2
        {
            var _loc_1:* = null;
            _loc_1 = m_ground.m_xf.position.Copy();
            _loc_1.Add(m_groundAnchor1);
            return _loc_1;
        }// end function

    }
}
