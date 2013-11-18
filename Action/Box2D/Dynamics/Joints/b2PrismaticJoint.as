package Box2D.Dynamics.Joints
{
    import Box2D.Common.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;

    public class b2PrismaticJoint extends b2Joint
    {
        public var m_limitForce:Number;
        public var m_refAngle:Number;
        public var m_lowerTranslation:Number;
        public var m_localXAxis1:b2Vec2;
        public var m_torque:Number;
        public var m_enableLimit:Boolean;
        public var m_motorForce:Number;
        public var m_force:Number;
        public var m_localYAxis1:b2Vec2;
        public var m_motorMass:Number;
        public var m_maxMotorForce:Number;
        public var m_localAnchor1:b2Vec2;
        public var m_localAnchor2:b2Vec2;
        public var m_angularMass:Number;
        public var m_limitState:int;
        public var m_linearMass:Number;
        public var m_upperTranslation:Number;
        public var m_motorJacobian:b2Jacobian;
        public var m_limitPositionImpulse:Number;
        public var m_motorSpeed:Number;
        public var m_linearJacobian:b2Jacobian;
        public var m_enableMotor:Boolean;

        public function b2PrismaticJoint(param1:b2PrismaticJointDef)
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            m_localAnchor1 = new b2Vec2();
            m_localAnchor2 = new b2Vec2();
            m_localXAxis1 = new b2Vec2();
            m_localYAxis1 = new b2Vec2();
            m_linearJacobian = new b2Jacobian();
            m_motorJacobian = new b2Jacobian();
            super(param1);
            m_localAnchor1.SetV(param1.localAnchor1);
            m_localAnchor2.SetV(param1.localAnchor2);
            m_localXAxis1.SetV(param1.localAxis1);
            m_localYAxis1.x = -m_localXAxis1.y;
            m_localYAxis1.y = m_localXAxis1.x;
            m_refAngle = param1.referenceAngle;
            m_linearJacobian.SetZero();
            m_linearMass = 0;
            m_force = 0;
            m_angularMass = 0;
            m_torque = 0;
            m_motorJacobian.SetZero();
            m_motorMass = 0;
            m_motorForce = 0;
            m_limitForce = 0;
            m_limitPositionImpulse = 0;
            m_lowerTranslation = param1.lowerTranslation;
            m_upperTranslation = param1.upperTranslation;
            m_maxMotorForce = param1.maxMotorForce;
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
            return m_upperTranslation;
        }// end function

        public function GetLowerLimit() : Number
        {
            return m_lowerTranslation;
        }// end function

        public function GetJointTranslation() : Number
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            _loc_1 = m_body1;
            _loc_2 = m_body2;
            _loc_4 = _loc_1.GetWorldPoint(m_localAnchor1);
            _loc_5 = _loc_2.GetWorldPoint(m_localAnchor2);
            _loc_6 = _loc_5.x - _loc_4.x;
            _loc_7 = _loc_5.y - _loc_4.y;
            _loc_8 = _loc_1.GetWorldVector(m_localXAxis1);
            _loc_9 = _loc_8.x * _loc_6 + _loc_8.y * _loc_7;
            return _loc_9;
        }// end function

        public function SetLimits(param1:Number, param2:Number) : void
        {
            m_lowerTranslation = param1;
            m_upperTranslation = param2;
            return;
        }// end function

        public function GetMotorSpeed() : Number
        {
            return m_motorSpeed;
        }// end function

        override public function GetReactionForce() : b2Vec2
        {
            var _loc_1:* = null;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            _loc_1 = m_body1.m_xf.R;
            _loc_2 = m_limitForce * (_loc_1.col1.x * m_localXAxis1.x + _loc_1.col2.x * m_localXAxis1.y);
            _loc_3 = m_limitForce * (_loc_1.col1.y * m_localXAxis1.x + _loc_1.col2.y * m_localXAxis1.y);
            _loc_4 = m_force * (_loc_1.col1.x * m_localYAxis1.x + _loc_1.col2.x * m_localYAxis1.y);
            _loc_5 = m_force * (_loc_1.col1.y * m_localYAxis1.x + _loc_1.col2.y * m_localYAxis1.y);
            return new b2Vec2(m_limitForce * _loc_2 + m_force * _loc_4, m_limitForce * _loc_3 + m_force * _loc_5);
        }// end function

        override public function SolvePositionConstraints() : Boolean
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = null;
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
            var _loc_27:* = NaN;
            var _loc_28:* = NaN;
            var _loc_29:* = NaN;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            var _loc_32:* = NaN;
            _loc_3 = m_body1;
            _loc_4 = m_body2;
            _loc_5 = _loc_3.m_invMass;
            _loc_6 = _loc_4.m_invMass;
            _loc_7 = _loc_3.m_invI;
            _loc_8 = _loc_4.m_invI;
            _loc_9 = _loc_3.m_xf.R;
            _loc_11 = m_localAnchor1.x - _loc_3.m_sweep.localCenter.x;
            _loc_12 = m_localAnchor1.y - _loc_3.m_sweep.localCenter.y;
            _loc_10 = _loc_9.col1.x * _loc_11 + _loc_9.col2.x * _loc_12;
            _loc_12 = _loc_9.col1.y * _loc_11 + _loc_9.col2.y * _loc_12;
            _loc_11 = _loc_10;
            _loc_9 = _loc_4.m_xf.R;
            _loc_13 = m_localAnchor2.x - _loc_4.m_sweep.localCenter.x;
            _loc_14 = m_localAnchor2.y - _loc_4.m_sweep.localCenter.y;
            _loc_10 = _loc_9.col1.x * _loc_13 + _loc_9.col2.x * _loc_14;
            _loc_14 = _loc_9.col1.y * _loc_13 + _loc_9.col2.y * _loc_14;
            _loc_13 = _loc_10;
            _loc_15 = _loc_3.m_sweep.c.x + _loc_11;
            _loc_16 = _loc_3.m_sweep.c.y + _loc_12;
            _loc_17 = _loc_4.m_sweep.c.x + _loc_13;
            _loc_18 = _loc_4.m_sweep.c.y + _loc_14;
            _loc_19 = _loc_17 - _loc_15;
            _loc_20 = _loc_18 - _loc_16;
            _loc_9 = _loc_3.m_xf.R;
            _loc_21 = _loc_9.col1.x * m_localYAxis1.x + _loc_9.col2.x * m_localYAxis1.y;
            _loc_22 = _loc_9.col1.y * m_localYAxis1.x + _loc_9.col2.y * m_localYAxis1.y;
            _loc_23 = _loc_21 * _loc_19 + _loc_22 * _loc_20;
            _loc_23 = b2Math.b2Clamp(_loc_23, -b2Settings.b2_maxLinearCorrection, b2Settings.b2_maxLinearCorrection);
            _loc_24 = (-m_linearMass) * _loc_23;
            _loc_3.m_sweep.c.x = _loc_3.m_sweep.c.x + _loc_5 * _loc_24 * m_linearJacobian.linear1.x;
            _loc_3.m_sweep.c.y = _loc_3.m_sweep.c.y + _loc_5 * _loc_24 * m_linearJacobian.linear1.y;
            _loc_3.m_sweep.a = _loc_3.m_sweep.a + _loc_7 * _loc_24 * m_linearJacobian.angular1;
            _loc_4.m_sweep.c.x = _loc_4.m_sweep.c.x + _loc_6 * _loc_24 * m_linearJacobian.linear2.x;
            _loc_4.m_sweep.c.y = _loc_4.m_sweep.c.y + _loc_6 * _loc_24 * m_linearJacobian.linear2.y;
            _loc_4.m_sweep.a = _loc_4.m_sweep.a + _loc_8 * _loc_24 * m_linearJacobian.angular2;
            _loc_25 = b2Math.b2Abs(_loc_23);
            _loc_26 = _loc_4.m_sweep.a - _loc_3.m_sweep.a - m_refAngle;
            _loc_26 = b2Math.b2Clamp(_loc_26, -b2Settings.b2_maxAngularCorrection, b2Settings.b2_maxAngularCorrection);
            _loc_27 = (-m_angularMass) * _loc_26;
            _loc_3.m_sweep.a = _loc_3.m_sweep.a - _loc_3.m_invI * _loc_27;
            _loc_4.m_sweep.a = _loc_4.m_sweep.a + _loc_4.m_invI * _loc_27;
            _loc_3.SynchronizeTransform();
            _loc_4.SynchronizeTransform();
            _loc_28 = b2Math.b2Abs(_loc_26);
            if (m_enableLimit && m_limitState != e_inactiveLimit)
            {
                _loc_9 = _loc_3.m_xf.R;
                _loc_11 = m_localAnchor1.x - _loc_3.m_sweep.localCenter.x;
                _loc_12 = m_localAnchor1.y - _loc_3.m_sweep.localCenter.y;
                _loc_10 = _loc_9.col1.x * _loc_11 + _loc_9.col2.x * _loc_12;
                _loc_12 = _loc_9.col1.y * _loc_11 + _loc_9.col2.y * _loc_12;
                _loc_11 = _loc_10;
                _loc_9 = _loc_4.m_xf.R;
                _loc_13 = m_localAnchor2.x - _loc_4.m_sweep.localCenter.x;
                _loc_14 = m_localAnchor2.y - _loc_4.m_sweep.localCenter.y;
                _loc_10 = _loc_9.col1.x * _loc_13 + _loc_9.col2.x * _loc_14;
                _loc_14 = _loc_9.col1.y * _loc_13 + _loc_9.col2.y * _loc_14;
                _loc_13 = _loc_10;
                _loc_15 = _loc_3.m_sweep.c.x + _loc_11;
                _loc_16 = _loc_3.m_sweep.c.y + _loc_12;
                _loc_17 = _loc_4.m_sweep.c.x + _loc_13;
                _loc_18 = _loc_4.m_sweep.c.y + _loc_14;
                _loc_19 = _loc_17 - _loc_15;
                _loc_20 = _loc_18 - _loc_16;
                _loc_9 = _loc_3.m_xf.R;
                _loc_29 = _loc_9.col1.x * m_localXAxis1.x + _loc_9.col2.x * m_localXAxis1.y;
                _loc_30 = _loc_9.col1.y * m_localXAxis1.x + _loc_9.col2.y * m_localXAxis1.y;
                _loc_31 = _loc_29 * _loc_19 + _loc_30 * _loc_20;
                _loc_32 = 0;
                if (m_limitState == e_equalLimits)
                {
                    _loc_1 = b2Math.b2Clamp(_loc_31, -b2Settings.b2_maxLinearCorrection, b2Settings.b2_maxLinearCorrection);
                    _loc_32 = (-m_motorMass) * _loc_1;
                    _loc_25 = b2Math.b2Max(_loc_25, b2Math.b2Abs(_loc_26));
                }
                else if (m_limitState == e_atLowerLimit)
                {
                    _loc_1 = _loc_31 - m_lowerTranslation;
                    _loc_25 = b2Math.b2Max(_loc_25, -_loc_1);
                    _loc_1 = b2Math.b2Clamp(_loc_1 + b2Settings.b2_linearSlop, -b2Settings.b2_maxLinearCorrection, 0);
                    _loc_32 = (-m_motorMass) * _loc_1;
                    _loc_2 = m_limitPositionImpulse;
                    m_limitPositionImpulse = b2Math.b2Max(m_limitPositionImpulse + _loc_32, 0);
                    _loc_32 = m_limitPositionImpulse - _loc_2;
                }
                else if (m_limitState == e_atUpperLimit)
                {
                    _loc_1 = _loc_31 - m_upperTranslation;
                    _loc_25 = b2Math.b2Max(_loc_25, _loc_1);
                    _loc_1 = b2Math.b2Clamp(_loc_1 - b2Settings.b2_linearSlop, 0, b2Settings.b2_maxLinearCorrection);
                    _loc_32 = (-m_motorMass) * _loc_1;
                    _loc_2 = m_limitPositionImpulse;
                    m_limitPositionImpulse = b2Math.b2Min(m_limitPositionImpulse + _loc_32, 0);
                    _loc_32 = m_limitPositionImpulse - _loc_2;
                }
                _loc_3.m_sweep.c.x = _loc_3.m_sweep.c.x + _loc_5 * _loc_32 * m_motorJacobian.linear1.x;
                _loc_3.m_sweep.c.y = _loc_3.m_sweep.c.y + _loc_5 * _loc_32 * m_motorJacobian.linear1.y;
                _loc_3.m_sweep.a = _loc_3.m_sweep.a + _loc_7 * _loc_32 * m_motorJacobian.angular1;
                _loc_4.m_sweep.c.x = _loc_4.m_sweep.c.x + _loc_6 * _loc_32 * m_motorJacobian.linear2.x;
                _loc_4.m_sweep.c.y = _loc_4.m_sweep.c.y + _loc_6 * _loc_32 * m_motorJacobian.linear2.y;
                _loc_4.m_sweep.a = _loc_4.m_sweep.a + _loc_8 * _loc_32 * m_motorJacobian.angular2;
                _loc_3.SynchronizeTransform();
                _loc_4.SynchronizeTransform();
            }
            return _loc_25 <= b2Settings.b2_linearSlop && _loc_28 <= b2Settings.b2_angularSlop;
        }// end function

        public function GetJointSpeed() : Number
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
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            _loc_1 = m_body1;
            _loc_2 = m_body2;
            _loc_3 = _loc_1.m_xf.R;
            _loc_4 = m_localAnchor1.x - _loc_1.m_sweep.localCenter.x;
            _loc_5 = m_localAnchor1.y - _loc_1.m_sweep.localCenter.y;
            _loc_6 = _loc_3.col1.x * _loc_4 + _loc_3.col2.x * _loc_5;
            _loc_5 = _loc_3.col1.y * _loc_4 + _loc_3.col2.y * _loc_5;
            _loc_4 = _loc_6;
            _loc_3 = _loc_2.m_xf.R;
            _loc_7 = m_localAnchor2.x - _loc_2.m_sweep.localCenter.x;
            _loc_8 = m_localAnchor2.y - _loc_2.m_sweep.localCenter.y;
            _loc_6 = _loc_3.col1.x * _loc_7 + _loc_3.col2.x * _loc_8;
            _loc_8 = _loc_3.col1.y * _loc_7 + _loc_3.col2.y * _loc_8;
            _loc_7 = _loc_6;
            _loc_9 = _loc_1.m_sweep.c.x + _loc_4;
            _loc_10 = _loc_1.m_sweep.c.y + _loc_5;
            _loc_11 = _loc_2.m_sweep.c.x + _loc_7;
            _loc_12 = _loc_2.m_sweep.c.y + _loc_8;
            _loc_13 = _loc_11 - _loc_9;
            _loc_14 = _loc_12 - _loc_10;
            _loc_15 = _loc_1.GetWorldVector(m_localXAxis1);
            _loc_16 = _loc_1.m_linearVelocity;
            _loc_17 = _loc_2.m_linearVelocity;
            _loc_18 = _loc_1.m_angularVelocity;
            _loc_19 = _loc_2.m_angularVelocity;
            _loc_20 = _loc_13 * ((-_loc_18) * _loc_15.y) + _loc_14 * (_loc_18 * _loc_15.x) + (_loc_15.x * (_loc_17.x + (-_loc_19) * _loc_8 - _loc_16.x - (-_loc_18) * _loc_5) + _loc_15.y * (_loc_17.y + _loc_19 * _loc_7 - _loc_16.y - _loc_18 * _loc_4));
            return _loc_20;
        }// end function

        public function SetMotorSpeed(param1:Number) : void
        {
            m_motorSpeed = param1;
            return;
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
            var _loc_27:* = NaN;
            var _loc_28:* = NaN;
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
            _loc_4 = _loc_2.m_xf.R;
            _loc_14 = _loc_4.col1.x * m_localYAxis1.x + _loc_4.col2.x * m_localYAxis1.y;
            _loc_15 = _loc_4.col1.y * m_localYAxis1.x + _loc_4.col2.y * m_localYAxis1.y;
            _loc_16 = _loc_3.m_sweep.c.x + _loc_8 - _loc_2.m_sweep.c.x;
            _loc_17 = _loc_3.m_sweep.c.y + _loc_9 - _loc_2.m_sweep.c.y;
            m_linearJacobian.linear1.x = -_loc_14;
            m_linearJacobian.linear1.y = -_loc_15;
            m_linearJacobian.linear2.x = _loc_14;
            m_linearJacobian.linear2.y = _loc_15;
            m_linearJacobian.angular1 = -(_loc_16 * _loc_15 - _loc_17 * _loc_14);
            m_linearJacobian.angular2 = _loc_8 * _loc_15 - _loc_9 * _loc_14;
            m_linearMass = _loc_10 + _loc_12 * m_linearJacobian.angular1 * m_linearJacobian.angular1 + _loc_11 + _loc_13 * m_linearJacobian.angular2 * m_linearJacobian.angular2;
            m_linearMass = 1 / m_linearMass;
            m_angularMass = _loc_12 + _loc_13;
            if (m_angularMass > Number.MIN_VALUE)
            {
                m_angularMass = 1 / m_angularMass;
            }
            if (m_enableLimit || m_enableMotor)
            {
                _loc_4 = _loc_2.m_xf.R;
                _loc_18 = _loc_4.col1.x * m_localXAxis1.x + _loc_4.col2.x * m_localXAxis1.y;
                _loc_19 = _loc_4.col1.y * m_localXAxis1.x + _loc_4.col2.y * m_localXAxis1.y;
                m_motorJacobian.linear1.x = -_loc_18;
                m_motorJacobian.linear1.y = -_loc_19;
                m_motorJacobian.linear2.x = _loc_18;
                m_motorJacobian.linear2.y = _loc_19;
                m_motorJacobian.angular1 = -(_loc_16 * _loc_19 - _loc_17 * _loc_18);
                m_motorJacobian.angular2 = _loc_8 * _loc_19 - _loc_9 * _loc_18;
                m_motorMass = _loc_10 + _loc_12 * m_motorJacobian.angular1 * m_motorJacobian.angular1 + _loc_11 + _loc_13 * m_motorJacobian.angular2 * m_motorJacobian.angular2;
                m_motorMass = 1 / m_motorMass;
                if (m_enableLimit)
                {
                    _loc_20 = _loc_16 - _loc_6;
                    _loc_21 = _loc_17 - _loc_7;
                    _loc_22 = _loc_18 * _loc_20 + _loc_19 * _loc_21;
                    if (b2Math.b2Abs(m_upperTranslation - m_lowerTranslation) < 2 * b2Settings.b2_linearSlop)
                    {
                        m_limitState = e_equalLimits;
                    }
                    else if (_loc_22 <= m_lowerTranslation)
                    {
                        if (m_limitState != e_atLowerLimit)
                        {
                            m_limitForce = 0;
                        }
                        m_limitState = e_atLowerLimit;
                    }
                    else if (_loc_22 >= m_upperTranslation)
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
            }
            if (m_enableMotor == false)
            {
                m_motorForce = 0;
            }
            if (m_enableLimit == false)
            {
                m_limitForce = 0;
            }
            if (param1.warmStarting)
            {
                _loc_23 = param1.dt * (m_force * m_linearJacobian.linear1.x + (m_motorForce + m_limitForce) * m_motorJacobian.linear1.x);
                _loc_24 = param1.dt * (m_force * m_linearJacobian.linear1.y + (m_motorForce + m_limitForce) * m_motorJacobian.linear1.y);
                _loc_25 = param1.dt * (m_force * m_linearJacobian.linear2.x + (m_motorForce + m_limitForce) * m_motorJacobian.linear2.x);
                _loc_26 = param1.dt * (m_force * m_linearJacobian.linear2.y + (m_motorForce + m_limitForce) * m_motorJacobian.linear2.y);
                _loc_27 = param1.dt * (m_force * m_linearJacobian.angular1 - m_torque + (m_motorForce + m_limitForce) * m_motorJacobian.angular1);
                _loc_28 = param1.dt * (m_force * m_linearJacobian.angular2 + m_torque + (m_motorForce + m_limitForce) * m_motorJacobian.angular2);
                _loc_2.m_linearVelocity.x = _loc_2.m_linearVelocity.x + _loc_10 * _loc_23;
                _loc_2.m_linearVelocity.y = _loc_2.m_linearVelocity.y + _loc_10 * _loc_24;
                _loc_2.m_angularVelocity = _loc_2.m_angularVelocity + _loc_12 * _loc_27;
                _loc_3.m_linearVelocity.x = _loc_3.m_linearVelocity.x + _loc_11 * _loc_25;
                _loc_3.m_linearVelocity.y = _loc_3.m_linearVelocity.y + _loc_11 * _loc_26;
                _loc_3.m_angularVelocity = _loc_3.m_angularVelocity + _loc_13 * _loc_28;
            }
            else
            {
                m_force = 0;
                m_torque = 0;
                m_limitForce = 0;
                m_motorForce = 0;
            }
            m_limitPositionImpulse = 0;
            return;
        }// end function

        public function GetMotorForce() : Number
        {
            return m_motorForce;
        }// end function

        public function SetMaxMotorForce(param1:Number) : void
        {
            m_maxMotorForce = param1;
            return;
        }// end function

        public function EnableLimit(param1:Boolean) : void
        {
            m_enableLimit = param1;
            return;
        }// end function

        override public function GetReactionTorque() : Number
        {
            return m_torque;
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
            _loc_2 = m_body1;
            _loc_3 = m_body2;
            _loc_4 = _loc_2.m_invMass;
            _loc_5 = _loc_3.m_invMass;
            _loc_6 = _loc_2.m_invI;
            _loc_7 = _loc_3.m_invI;
            _loc_9 = m_linearJacobian.Compute(_loc_2.m_linearVelocity, _loc_2.m_angularVelocity, _loc_3.m_linearVelocity, _loc_3.m_angularVelocity);
            _loc_10 = (-param1.inv_dt) * m_linearMass * _loc_9;
            m_force = m_force + _loc_10;
            _loc_11 = param1.dt * _loc_10;
            _loc_2.m_linearVelocity.x = _loc_2.m_linearVelocity.x + _loc_4 * _loc_11 * m_linearJacobian.linear1.x;
            _loc_2.m_linearVelocity.y = _loc_2.m_linearVelocity.y + _loc_4 * _loc_11 * m_linearJacobian.linear1.y;
            _loc_2.m_angularVelocity = _loc_2.m_angularVelocity + _loc_6 * _loc_11 * m_linearJacobian.angular1;
            _loc_3.m_linearVelocity.x = _loc_3.m_linearVelocity.x + _loc_5 * _loc_11 * m_linearJacobian.linear2.x;
            _loc_3.m_linearVelocity.y = _loc_3.m_linearVelocity.y + _loc_5 * _loc_11 * m_linearJacobian.linear2.y;
            _loc_3.m_angularVelocity = _loc_3.m_angularVelocity + _loc_7 * _loc_11 * m_linearJacobian.angular2;
            _loc_12 = _loc_3.m_angularVelocity - _loc_2.m_angularVelocity;
            _loc_13 = (-param1.inv_dt) * m_angularMass * _loc_12;
            m_torque = m_torque + _loc_13;
            _loc_14 = param1.dt * _loc_13;
            _loc_2.m_angularVelocity = _loc_2.m_angularVelocity - _loc_6 * _loc_14;
            _loc_3.m_angularVelocity = _loc_3.m_angularVelocity + _loc_7 * _loc_14;
            if (m_enableMotor && m_limitState != e_equalLimits)
            {
                _loc_15 = m_motorJacobian.Compute(_loc_2.m_linearVelocity, _loc_2.m_angularVelocity, _loc_3.m_linearVelocity, _loc_3.m_angularVelocity) - m_motorSpeed;
                _loc_16 = (-param1.inv_dt) * m_motorMass * _loc_15;
                _loc_17 = m_motorForce;
                m_motorForce = b2Math.b2Clamp(m_motorForce + _loc_16, -m_maxMotorForce, m_maxMotorForce);
                _loc_16 = m_motorForce - _loc_17;
                _loc_11 = param1.dt * _loc_16;
                _loc_2.m_linearVelocity.x = _loc_2.m_linearVelocity.x + _loc_4 * _loc_11 * m_motorJacobian.linear1.x;
                _loc_2.m_linearVelocity.y = _loc_2.m_linearVelocity.y + _loc_4 * _loc_11 * m_motorJacobian.linear1.y;
                _loc_2.m_angularVelocity = _loc_2.m_angularVelocity + _loc_6 * _loc_11 * m_motorJacobian.angular1;
                _loc_3.m_linearVelocity.x = _loc_3.m_linearVelocity.x + _loc_5 * _loc_11 * m_motorJacobian.linear2.x;
                _loc_3.m_linearVelocity.y = _loc_3.m_linearVelocity.y + _loc_5 * _loc_11 * m_motorJacobian.linear2.y;
                _loc_3.m_angularVelocity = _loc_3.m_angularVelocity + _loc_7 * _loc_11 * m_motorJacobian.angular2;
            }
            if (m_enableLimit && m_limitState != e_inactiveLimit)
            {
                _loc_18 = m_motorJacobian.Compute(_loc_2.m_linearVelocity, _loc_2.m_angularVelocity, _loc_3.m_linearVelocity, _loc_3.m_angularVelocity);
                _loc_19 = (-param1.inv_dt) * m_motorMass * _loc_18;
                if (m_limitState == e_equalLimits)
                {
                    m_limitForce = m_limitForce + _loc_19;
                }
                else if (m_limitState == e_atLowerLimit)
                {
                    _loc_8 = m_limitForce;
                    m_limitForce = b2Math.b2Max(m_limitForce + _loc_19, 0);
                    _loc_19 = m_limitForce - _loc_8;
                }
                else if (m_limitState == e_atUpperLimit)
                {
                    _loc_8 = m_limitForce;
                    m_limitForce = b2Math.b2Min(m_limitForce + _loc_19, 0);
                    _loc_19 = m_limitForce - _loc_8;
                }
                _loc_11 = param1.dt * _loc_19;
                _loc_2.m_linearVelocity.x = _loc_2.m_linearVelocity.x + _loc_4 * _loc_11 * m_motorJacobian.linear1.x;
                _loc_2.m_linearVelocity.y = _loc_2.m_linearVelocity.y + _loc_4 * _loc_11 * m_motorJacobian.linear1.y;
                _loc_2.m_angularVelocity = _loc_2.m_angularVelocity + _loc_6 * _loc_11 * m_motorJacobian.angular1;
                _loc_3.m_linearVelocity.x = _loc_3.m_linearVelocity.x + _loc_5 * _loc_11 * m_motorJacobian.linear2.x;
                _loc_3.m_linearVelocity.y = _loc_3.m_linearVelocity.y + _loc_5 * _loc_11 * m_motorJacobian.linear2.y;
                _loc_3.m_angularVelocity = _loc_3.m_angularVelocity + _loc_7 * _loc_11 * m_motorJacobian.angular2;
            }
            return;
        }// end function

    }
}
