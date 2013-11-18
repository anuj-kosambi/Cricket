package Box2D.Dynamics.Joints
{
    import Box2D.Common.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;

    public class b2RevoluteJoint extends b2Joint
    {
        public var m_limitForce:Number;
        public var m_motorForce:Number;
        public var m_pivotMass:b2Mat22;
        public var m_enableLimit:Boolean;
        public var m_limitState:int;
        public var m_motorMass:Number;
        public var m_localAnchor1:b2Vec2;
        public var m_localAnchor2:b2Vec2;
        private var K1:b2Mat22;
        private var K2:b2Mat22;
        private var K3:b2Mat22;
        private var K:b2Mat22;
        public var m_pivotForce:b2Vec2;
        public var m_motorSpeed:Number;
        public var m_enableMotor:Boolean;
        public var m_limitPositionImpulse:Number;
        public var m_maxMotorTorque:Number;
        public var m_referenceAngle:Number;
        public var m_lowerAngle:Number;
        public var m_upperAngle:Number;
        public static var tImpulse:b2Vec2 = new b2Vec2();

        public function b2RevoluteJoint(param1:b2RevoluteJointDef)
        {
            K = new b2Mat22();
            K1 = new b2Mat22();
            K2 = new b2Mat22();
            K3 = new b2Mat22();
            m_localAnchor1 = new b2Vec2();
            m_localAnchor2 = new b2Vec2();
            m_pivotForce = new b2Vec2();
            m_pivotMass = new b2Mat22();
            super(param1);
            m_localAnchor1.SetV(param1.localAnchor1);
            m_localAnchor2.SetV(param1.localAnchor2);
            m_referenceAngle = param1.referenceAngle;
            m_pivotForce.Set(0, 0);
            m_motorForce = 0;
            m_limitForce = 0;
            m_limitPositionImpulse = 0;
            m_lowerAngle = param1.lowerAngle;
            m_upperAngle = param1.upperAngle;
            m_maxMotorTorque = param1.maxMotorTorque;
            m_motorSpeed = param1.motorSpeed;
            m_enableLimit = param1.enableLimit;
            m_enableMotor = param1.enableMotor;
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

        public function EnableMotor(param1:Boolean) : void
        {
            m_enableMotor = param1;
            return;
        }// end function

        public function GetUpperLimit() : Number
        {
            return m_upperAngle;
        }// end function

        public function GetLowerLimit() : Number
        {
            return m_lowerAngle;
        }// end function

        public function SetLimits(param1:Number, param2:Number) : void
        {
            m_lowerAngle = param1;
            m_upperAngle = param2;
            return;
        }// end function

        public function GetMotorSpeed() : Number
        {
            return m_motorSpeed;
        }// end function

        override public function GetReactionForce() : b2Vec2
        {
            return m_pivotForce;
        }// end function

        override public function SolvePositionConstraints() : Boolean
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = null;
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
            _loc_3 = m_body1;
            _loc_4 = m_body2;
            _loc_5 = 0;
            _loc_6 = _loc_3.m_xf.R;
            _loc_7 = m_localAnchor1.x - _loc_3.m_sweep.localCenter.x;
            _loc_8 = m_localAnchor1.y - _loc_3.m_sweep.localCenter.y;
            _loc_9 = _loc_6.col1.x * _loc_7 + _loc_6.col2.x * _loc_8;
            _loc_8 = _loc_6.col1.y * _loc_7 + _loc_6.col2.y * _loc_8;
            _loc_7 = _loc_9;
            _loc_6 = _loc_4.m_xf.R;
            _loc_10 = m_localAnchor2.x - _loc_4.m_sweep.localCenter.x;
            _loc_11 = m_localAnchor2.y - _loc_4.m_sweep.localCenter.y;
            _loc_9 = _loc_6.col1.x * _loc_10 + _loc_6.col2.x * _loc_11;
            _loc_11 = _loc_6.col1.y * _loc_10 + _loc_6.col2.y * _loc_11;
            _loc_10 = _loc_9;
            _loc_12 = _loc_3.m_sweep.c.x + _loc_7;
            _loc_13 = _loc_3.m_sweep.c.y + _loc_8;
            _loc_14 = _loc_4.m_sweep.c.x + _loc_10;
            _loc_15 = _loc_4.m_sweep.c.y + _loc_11;
            _loc_16 = _loc_14 - _loc_12;
            _loc_17 = _loc_15 - _loc_13;
            _loc_5 = Math.sqrt(_loc_16 * _loc_16 + _loc_17 * _loc_17);
            _loc_18 = _loc_3.m_invMass;
            _loc_19 = _loc_4.m_invMass;
            _loc_20 = _loc_3.m_invI;
            _loc_21 = _loc_4.m_invI;
            K1.col1.x = _loc_18 + _loc_19;
            K1.col2.x = 0;
            K1.col1.y = 0;
            K1.col2.y = _loc_18 + _loc_19;
            K2.col1.x = _loc_20 * _loc_8 * _loc_8;
            K2.col2.x = (-_loc_20) * _loc_7 * _loc_8;
            K2.col1.y = (-_loc_20) * _loc_7 * _loc_8;
            K2.col2.y = _loc_20 * _loc_7 * _loc_7;
            K3.col1.x = _loc_21 * _loc_11 * _loc_11;
            K3.col2.x = (-_loc_21) * _loc_10 * _loc_11;
            K3.col1.y = (-_loc_21) * _loc_10 * _loc_11;
            K3.col2.y = _loc_21 * _loc_10 * _loc_10;
            K.SetM(K1);
            K.AddM(K2);
            K.AddM(K3);
            K.Solve(tImpulse, -_loc_16, -_loc_17);
            _loc_22 = tImpulse.x;
            _loc_23 = tImpulse.y;
            _loc_3.m_sweep.c.x = _loc_3.m_sweep.c.x - _loc_3.m_invMass * _loc_22;
            _loc_3.m_sweep.c.y = _loc_3.m_sweep.c.y - _loc_3.m_invMass * _loc_23;
            _loc_3.m_sweep.a = _loc_3.m_sweep.a - _loc_3.m_invI * (_loc_7 * _loc_23 - _loc_8 * _loc_22);
            _loc_4.m_sweep.c.x = _loc_4.m_sweep.c.x + _loc_4.m_invMass * _loc_22;
            _loc_4.m_sweep.c.y = _loc_4.m_sweep.c.y + _loc_4.m_invMass * _loc_23;
            _loc_4.m_sweep.a = _loc_4.m_sweep.a + _loc_4.m_invI * (_loc_10 * _loc_23 - _loc_11 * _loc_22);
            _loc_3.SynchronizeTransform();
            _loc_4.SynchronizeTransform();
            _loc_24 = 0;
            if (m_enableLimit && m_limitState != e_inactiveLimit)
            {
                _loc_25 = _loc_4.m_sweep.a - _loc_3.m_sweep.a - m_referenceAngle;
                _loc_26 = 0;
                if (m_limitState == e_equalLimits)
                {
                    _loc_2 = b2Math.b2Clamp(_loc_25, -b2Settings.b2_maxAngularCorrection, b2Settings.b2_maxAngularCorrection);
                    _loc_26 = (-m_motorMass) * _loc_2;
                    _loc_24 = b2Math.b2Abs(_loc_2);
                }
                else if (m_limitState == e_atLowerLimit)
                {
                    _loc_2 = _loc_25 - m_lowerAngle;
                    _loc_24 = b2Math.b2Max(0, -_loc_2);
                    _loc_2 = b2Math.b2Clamp(_loc_2 + b2Settings.b2_angularSlop, -b2Settings.b2_maxAngularCorrection, 0);
                    _loc_26 = (-m_motorMass) * _loc_2;
                    _loc_1 = m_limitPositionImpulse;
                    m_limitPositionImpulse = b2Math.b2Max(m_limitPositionImpulse + _loc_26, 0);
                    _loc_26 = m_limitPositionImpulse - _loc_1;
                }
                else if (m_limitState == e_atUpperLimit)
                {
                    _loc_2 = _loc_25 - m_upperAngle;
                    _loc_24 = b2Math.b2Max(0, _loc_2);
                    _loc_2 = b2Math.b2Clamp(_loc_2 - b2Settings.b2_angularSlop, 0, b2Settings.b2_maxAngularCorrection);
                    _loc_26 = (-m_motorMass) * _loc_2;
                    _loc_1 = m_limitPositionImpulse;
                    m_limitPositionImpulse = b2Math.b2Min(m_limitPositionImpulse + _loc_26, 0);
                    _loc_26 = m_limitPositionImpulse - _loc_1;
                }
                _loc_3.m_sweep.a = _loc_3.m_sweep.a - _loc_3.m_invI * _loc_26;
                _loc_4.m_sweep.a = _loc_4.m_sweep.a + _loc_4.m_invI * _loc_26;
                _loc_3.SynchronizeTransform();
                _loc_4.SynchronizeTransform();
            }
            return _loc_5 <= b2Settings.b2_linearSlop && _loc_24 <= b2Settings.b2_angularSlop;
        }// end function

        public function GetJointSpeed() : Number
        {
            return m_body2.m_angularVelocity - m_body1.m_angularVelocity;
        }// end function

        public function SetMotorSpeed(param1:Number) : void
        {
            m_motorSpeed = param1;
            return;
        }// end function

        public function SetMaxMotorTorque(param1:Number) : void
        {
            m_maxMotorTorque = param1;
            return;
        }// end function

        public function GetJointAngle() : Number
        {
            return m_body2.m_sweep.a - m_body1.m_sweep.a - m_referenceAngle;
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
            _loc_2 = m_body1;
            _loc_3 = m_body2;
            _loc_4 = _loc_2.m_xf.R;
            _loc_6 = m_localAnchor1.x - _loc_2.m_sweep.localCenter.x;
            _loc_7 = m_localAnchor1.y - _loc_2.m_sweep.localCenter.y;
            _loc_5 = _loc_4.col1.x * _loc_6 + _loc_4.col2.x * _loc_7;
            _loc_7 = _loc_4.col1.y * _loc_6 + _loc_4.col2.y * _loc_7;
            _loc_6 = _loc_5;
            _loc_4 = _loc_3.m_xf.R;
            _loc_8 = m_localAnchor2.x - _loc_3.m_sweep.localCenter.x;
            _loc_9 = m_localAnchor2.y - _loc_3.m_sweep.localCenter.y;
            _loc_5 = _loc_4.col1.x * _loc_8 + _loc_4.col2.x * _loc_9;
            _loc_9 = _loc_4.col1.y * _loc_8 + _loc_4.col2.y * _loc_9;
            _loc_8 = _loc_5;
            _loc_10 = _loc_2.m_invMass;
            _loc_11 = _loc_3.m_invMass;
            _loc_12 = _loc_2.m_invI;
            _loc_13 = _loc_3.m_invI;
            K1.col1.x = _loc_10 + _loc_11;
            K1.col2.x = 0;
            K1.col1.y = 0;
            K1.col2.y = _loc_10 + _loc_11;
            K2.col1.x = _loc_12 * _loc_7 * _loc_7;
            K2.col2.x = (-_loc_12) * _loc_6 * _loc_7;
            K2.col1.y = (-_loc_12) * _loc_6 * _loc_7;
            K2.col2.y = _loc_12 * _loc_6 * _loc_6;
            K3.col1.x = _loc_13 * _loc_9 * _loc_9;
            K3.col2.x = (-_loc_13) * _loc_8 * _loc_9;
            K3.col1.y = (-_loc_13) * _loc_8 * _loc_9;
            K3.col2.y = _loc_13 * _loc_8 * _loc_8;
            K.SetM(K1);
            K.AddM(K2);
            K.AddM(K3);
            K.Invert(m_pivotMass);
            m_motorMass = 1 / (_loc_12 + _loc_13);
            if (m_enableMotor == false)
            {
                m_motorForce = 0;
            }
            if (m_enableLimit)
            {
                _loc_14 = _loc_3.m_sweep.a - _loc_2.m_sweep.a - m_referenceAngle;
                if (b2Math.b2Abs(m_upperAngle - m_lowerAngle) < 2 * b2Settings.b2_angularSlop)
                {
                    m_limitState = e_equalLimits;
                }
                else if (_loc_14 <= m_lowerAngle)
                {
                    if (m_limitState != e_atLowerLimit)
                    {
                        m_limitForce = 0;
                    }
                    m_limitState = e_atLowerLimit;
                }
                else if (_loc_14 >= m_upperAngle)
                {
                    if (m_limitState != e_atUpperLimit)
                    {
                        m_limitForce = 0;
                    }
                    m_limitState = e_atUpperLimit;
                }
                else
                {
                    m_limitState = e_inactiveLimit;
                    m_limitForce = 0;
                }
            }
            else
            {
                m_limitForce = 0;
            }
            if (param1.warmStarting)
            {
                _loc_2.m_linearVelocity.x = _loc_2.m_linearVelocity.x - param1.dt * _loc_10 * m_pivotForce.x;
                _loc_2.m_linearVelocity.y = _loc_2.m_linearVelocity.y - param1.dt * _loc_10 * m_pivotForce.y;
                _loc_2.m_angularVelocity = _loc_2.m_angularVelocity - param1.dt * _loc_12 * (_loc_6 * m_pivotForce.y - _loc_7 * m_pivotForce.x + m_motorForce + m_limitForce);
                _loc_3.m_linearVelocity.x = _loc_3.m_linearVelocity.x + param1.dt * _loc_11 * m_pivotForce.x;
                _loc_3.m_linearVelocity.y = _loc_3.m_linearVelocity.y + param1.dt * _loc_11 * m_pivotForce.y;
                _loc_3.m_angularVelocity = _loc_3.m_angularVelocity + param1.dt * _loc_13 * (_loc_8 * m_pivotForce.y - _loc_9 * m_pivotForce.x + m_motorForce + m_limitForce);
            }
            else
            {
                m_pivotForce.SetZero();
                m_motorForce = 0;
                m_limitForce = 0;
            }
            m_limitPositionImpulse = 0;
            return;
        }// end function

        public function EnableLimit(param1:Boolean) : void
        {
            m_enableLimit = param1;
            return;
        }// end function

        public function GetMotorTorque() : Number
        {
            return m_motorForce;
        }// end function

        override public function GetReactionTorque() : Number
        {
            return m_limitForce;
        }// end function

        public function IsLimitEnabled() : Boolean
        {
            return m_enableLimit;
        }// end function

        public function IsMotorEnabled() : Boolean
        {
            return m_enableMotor;
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
            var _loc_21:* = NaN;
            _loc_2 = m_body1;
            _loc_3 = m_body2;
            _loc_4 = _loc_2.m_xf.R;
            _loc_6 = m_localAnchor1.x - _loc_2.m_sweep.localCenter.x;
            _loc_7 = m_localAnchor1.y - _loc_2.m_sweep.localCenter.y;
            _loc_5 = _loc_4.col1.x * _loc_6 + _loc_4.col2.x * _loc_7;
            _loc_7 = _loc_4.col1.y * _loc_6 + _loc_4.col2.y * _loc_7;
            _loc_6 = _loc_5;
            _loc_4 = _loc_3.m_xf.R;
            _loc_8 = m_localAnchor2.x - _loc_3.m_sweep.localCenter.x;
            _loc_9 = m_localAnchor2.y - _loc_3.m_sweep.localCenter.y;
            _loc_5 = _loc_4.col1.x * _loc_8 + _loc_4.col2.x * _loc_9;
            _loc_9 = _loc_4.col1.y * _loc_8 + _loc_4.col2.y * _loc_9;
            _loc_8 = _loc_5;
            _loc_11 = _loc_3.m_linearVelocity.x + (-_loc_3.m_angularVelocity) * _loc_9 - _loc_2.m_linearVelocity.x - (-_loc_2.m_angularVelocity) * _loc_7;
            _loc_12 = _loc_3.m_linearVelocity.y + _loc_3.m_angularVelocity * _loc_8 - _loc_2.m_linearVelocity.y - _loc_2.m_angularVelocity * _loc_6;
            _loc_13 = (-param1.inv_dt) * (m_pivotMass.col1.x * _loc_11 + m_pivotMass.col2.x * _loc_12);
            _loc_14 = (-param1.inv_dt) * (m_pivotMass.col1.y * _loc_11 + m_pivotMass.col2.y * _loc_12);
            m_pivotForce.x = m_pivotForce.x + _loc_13;
            m_pivotForce.y = m_pivotForce.y + _loc_14;
            _loc_15 = param1.dt * _loc_13;
            _loc_16 = param1.dt * _loc_14;
            _loc_2.m_linearVelocity.x = _loc_2.m_linearVelocity.x - _loc_2.m_invMass * _loc_15;
            _loc_2.m_linearVelocity.y = _loc_2.m_linearVelocity.y - _loc_2.m_invMass * _loc_16;
            _loc_2.m_angularVelocity = _loc_2.m_angularVelocity - _loc_2.m_invI * (_loc_6 * _loc_16 - _loc_7 * _loc_15);
            _loc_3.m_linearVelocity.x = _loc_3.m_linearVelocity.x + _loc_3.m_invMass * _loc_15;
            _loc_3.m_linearVelocity.y = _loc_3.m_linearVelocity.y + _loc_3.m_invMass * _loc_16;
            _loc_3.m_angularVelocity = _loc_3.m_angularVelocity + _loc_3.m_invI * (_loc_8 * _loc_16 - _loc_9 * _loc_15);
            if (m_enableMotor && m_limitState != e_equalLimits)
            {
                _loc_17 = _loc_3.m_angularVelocity - _loc_2.m_angularVelocity - m_motorSpeed;
                _loc_18 = (-param1.inv_dt) * m_motorMass * _loc_17;
                _loc_19 = m_motorForce;
                m_motorForce = b2Math.b2Clamp(m_motorForce + _loc_18, -m_maxMotorTorque, m_maxMotorTorque);
                _loc_18 = m_motorForce - _loc_19;
                _loc_2.m_angularVelocity = _loc_2.m_angularVelocity - _loc_2.m_invI * param1.dt * _loc_18;
                _loc_3.m_angularVelocity = _loc_3.m_angularVelocity + _loc_3.m_invI * param1.dt * _loc_18;
            }
            if (m_enableLimit && m_limitState != e_inactiveLimit)
            {
                _loc_20 = _loc_3.m_angularVelocity - _loc_2.m_angularVelocity;
                _loc_21 = (-param1.inv_dt) * m_motorMass * _loc_20;
                if (m_limitState == e_equalLimits)
                {
                    m_limitForce = m_limitForce + _loc_21;
                }
                else if (m_limitState == e_atLowerLimit)
                {
                    _loc_10 = m_limitForce;
                    m_limitForce = b2Math.b2Max(m_limitForce + _loc_21, 0);
                    _loc_21 = m_limitForce - _loc_10;
                }
                else if (m_limitState == e_atUpperLimit)
                {
                    _loc_10 = m_limitForce;
                    m_limitForce = b2Math.b2Min(m_limitForce + _loc_21, 0);
                    _loc_21 = m_limitForce - _loc_10;
                }
                _loc_2.m_angularVelocity = _loc_2.m_angularVelocity - _loc_2.m_invI * param1.dt * _loc_21;
                _loc_3.m_angularVelocity = _loc_3.m_angularVelocity + _loc_3.m_invI * param1.dt * _loc_21;
            }
            return;
        }// end function

    }
}
