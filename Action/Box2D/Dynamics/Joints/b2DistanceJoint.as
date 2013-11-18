package Box2D.Dynamics.Joints
{
    import Box2D.Common.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;

    public class b2DistanceJoint extends b2Joint
    {
        public var m_mass:Number;
        public var m_u:b2Vec2;
        public var m_impulse:Number;
        public var m_dampingRatio:Number;
        public var m_frequencyHz:Number;
        public var m_localAnchor2:b2Vec2;
        public var m_localAnchor1:b2Vec2;
        public var m_bias:Number;
        public var m_gamma:Number;
        public var m_length:Number;

        public function b2DistanceJoint(param1:b2DistanceJointDef)
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            m_localAnchor1 = new b2Vec2();
            m_localAnchor2 = new b2Vec2();
            m_u = new b2Vec2();
            super(param1);
            m_localAnchor1.SetV(param1.localAnchor1);
            m_localAnchor2.SetV(param1.localAnchor2);
            m_length = param1.length;
            m_frequencyHz = param1.frequencyHz;
            m_dampingRatio = param1.dampingRatio;
            m_impulse = 0;
            m_gamma = 0;
            m_bias = 0;
            m_inv_dt = 0;
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
            _loc_1 = new b2Vec2();
            _loc_1.SetV(m_u);
            _loc_1.Multiply(m_inv_dt * m_impulse);
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
            if (m_frequencyHz > 0)
            {
                return true;
            }
            _loc_2 = m_body1;
            _loc_3 = m_body2;
            _loc_1 = _loc_2.m_xf.R;
            _loc_4 = m_localAnchor1.x - _loc_2.m_sweep.localCenter.x;
            _loc_5 = m_localAnchor1.y - _loc_2.m_sweep.localCenter.y;
            _loc_6 = _loc_1.col1.x * _loc_4 + _loc_1.col2.x * _loc_5;
            _loc_5 = _loc_1.col1.y * _loc_4 + _loc_1.col2.y * _loc_5;
            _loc_4 = _loc_6;
            _loc_1 = _loc_3.m_xf.R;
            _loc_7 = m_localAnchor2.x - _loc_3.m_sweep.localCenter.x;
            _loc_8 = m_localAnchor2.y - _loc_3.m_sweep.localCenter.y;
            _loc_6 = _loc_1.col1.x * _loc_7 + _loc_1.col2.x * _loc_8;
            _loc_8 = _loc_1.col1.y * _loc_7 + _loc_1.col2.y * _loc_8;
            _loc_7 = _loc_6;
            _loc_9 = _loc_3.m_sweep.c.x + _loc_7 - _loc_2.m_sweep.c.x - _loc_4;
            _loc_10 = _loc_3.m_sweep.c.y + _loc_8 - _loc_2.m_sweep.c.y - _loc_5;
            _loc_11 = Math.sqrt(_loc_9 * _loc_9 + _loc_10 * _loc_10);
            _loc_9 = _loc_9 / _loc_11;
            _loc_10 = _loc_10 / _loc_11;
            _loc_12 = _loc_11 - m_length;
            _loc_12 = b2Math.b2Clamp(_loc_12, -b2Settings.b2_maxLinearCorrection, b2Settings.b2_maxLinearCorrection);
            _loc_13 = (-m_mass) * _loc_12;
            m_u.Set(_loc_9, _loc_10);
            _loc_14 = _loc_13 * m_u.x;
            _loc_15 = _loc_13 * m_u.y;
            _loc_2.m_sweep.c.x = _loc_2.m_sweep.c.x - _loc_2.m_invMass * _loc_14;
            _loc_2.m_sweep.c.y = _loc_2.m_sweep.c.y - _loc_2.m_invMass * _loc_15;
            _loc_2.m_sweep.a = _loc_2.m_sweep.a - _loc_2.m_invI * (_loc_4 * _loc_15 - _loc_5 * _loc_14);
            _loc_3.m_sweep.c.x = _loc_3.m_sweep.c.x + _loc_3.m_invMass * _loc_14;
            _loc_3.m_sweep.c.y = _loc_3.m_sweep.c.y + _loc_3.m_invMass * _loc_15;
            _loc_3.m_sweep.a = _loc_3.m_sweep.a + _loc_3.m_invI * (_loc_7 * _loc_15 - _loc_8 * _loc_14);
            _loc_2.SynchronizeTransform();
            _loc_3.SynchronizeTransform();
            return b2Math.b2Abs(_loc_12) < b2Settings.b2_linearSlop;
        }// end function

        override public function InitVelocityConstraints(param1:b2TimeStep) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            var _loc_5:* = null;
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
            m_inv_dt = param1.inv_dt;
            _loc_4 = m_body1;
            _loc_5 = m_body2;
            _loc_2 = _loc_4.m_xf.R;
            _loc_6 = m_localAnchor1.x - _loc_4.m_sweep.localCenter.x;
            _loc_7 = m_localAnchor1.y - _loc_4.m_sweep.localCenter.y;
            _loc_3 = _loc_2.col1.x * _loc_6 + _loc_2.col2.x * _loc_7;
            _loc_7 = _loc_2.col1.y * _loc_6 + _loc_2.col2.y * _loc_7;
            _loc_6 = _loc_3;
            _loc_2 = _loc_5.m_xf.R;
            _loc_8 = m_localAnchor2.x - _loc_5.m_sweep.localCenter.x;
            _loc_9 = m_localAnchor2.y - _loc_5.m_sweep.localCenter.y;
            _loc_3 = _loc_2.col1.x * _loc_8 + _loc_2.col2.x * _loc_9;
            _loc_9 = _loc_2.col1.y * _loc_8 + _loc_2.col2.y * _loc_9;
            _loc_8 = _loc_3;
            m_u.x = _loc_5.m_sweep.c.x + _loc_8 - _loc_4.m_sweep.c.x - _loc_6;
            m_u.y = _loc_5.m_sweep.c.y + _loc_9 - _loc_4.m_sweep.c.y - _loc_7;
            _loc_10 = Math.sqrt(m_u.x * m_u.x + m_u.y * m_u.y);
            if (_loc_10 > b2Settings.b2_linearSlop)
            {
                m_u.Multiply(1 / _loc_10);
            }
            else
            {
                m_u.SetZero();
            }
            _loc_11 = _loc_6 * m_u.y - _loc_7 * m_u.x;
            _loc_12 = _loc_8 * m_u.y - _loc_9 * m_u.x;
            _loc_13 = _loc_4.m_invMass + _loc_4.m_invI * _loc_11 * _loc_11 + _loc_5.m_invMass + _loc_5.m_invI * _loc_12 * _loc_12;
            m_mass = 1 / _loc_13;
            if (m_frequencyHz > 0)
            {
                _loc_14 = _loc_10 - m_length;
                _loc_15 = 2 * Math.PI * m_frequencyHz;
                _loc_16 = 2 * m_mass * m_dampingRatio * _loc_15;
                _loc_17 = m_mass * _loc_15 * _loc_15;
                m_gamma = 1 / (param1.dt * (_loc_16 + param1.dt * _loc_17));
                m_bias = _loc_14 * param1.dt * _loc_17 * m_gamma;
                m_mass = 1 / (_loc_13 + m_gamma);
            }
            if (param1.warmStarting)
            {
                m_impulse = m_impulse * param1.dtRatio;
                _loc_18 = m_impulse * m_u.x;
                _loc_19 = m_impulse * m_u.y;
                _loc_4.m_linearVelocity.x = _loc_4.m_linearVelocity.x - _loc_4.m_invMass * _loc_18;
                _loc_4.m_linearVelocity.y = _loc_4.m_linearVelocity.y - _loc_4.m_invMass * _loc_19;
                _loc_4.m_angularVelocity = _loc_4.m_angularVelocity - _loc_4.m_invI * (_loc_6 * _loc_19 - _loc_7 * _loc_18);
                _loc_5.m_linearVelocity.x = _loc_5.m_linearVelocity.x + _loc_5.m_invMass * _loc_18;
                _loc_5.m_linearVelocity.y = _loc_5.m_linearVelocity.y + _loc_5.m_invMass * _loc_19;
                _loc_5.m_angularVelocity = _loc_5.m_angularVelocity + _loc_5.m_invI * (_loc_8 * _loc_19 - _loc_9 * _loc_18);
            }
            else
            {
                m_impulse = 0;
            }
            return;
        }// end function

        override public function GetReactionTorque() : Number
        {
            return 0;
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
            _loc_3 = m_body1;
            _loc_4 = m_body2;
            _loc_2 = _loc_3.m_xf.R;
            _loc_5 = m_localAnchor1.x - _loc_3.m_sweep.localCenter.x;
            _loc_6 = m_localAnchor1.y - _loc_3.m_sweep.localCenter.y;
            _loc_7 = _loc_2.col1.x * _loc_5 + _loc_2.col2.x * _loc_6;
            _loc_6 = _loc_2.col1.y * _loc_5 + _loc_2.col2.y * _loc_6;
            _loc_5 = _loc_7;
            _loc_2 = _loc_4.m_xf.R;
            _loc_8 = m_localAnchor2.x - _loc_4.m_sweep.localCenter.x;
            _loc_9 = m_localAnchor2.y - _loc_4.m_sweep.localCenter.y;
            _loc_7 = _loc_2.col1.x * _loc_8 + _loc_2.col2.x * _loc_9;
            _loc_9 = _loc_2.col1.y * _loc_8 + _loc_2.col2.y * _loc_9;
            _loc_8 = _loc_7;
            _loc_10 = _loc_3.m_linearVelocity.x + (-_loc_3.m_angularVelocity) * _loc_6;
            _loc_11 = _loc_3.m_linearVelocity.y + _loc_3.m_angularVelocity * _loc_5;
            _loc_12 = _loc_4.m_linearVelocity.x + (-_loc_4.m_angularVelocity) * _loc_9;
            _loc_13 = _loc_4.m_linearVelocity.y + _loc_4.m_angularVelocity * _loc_8;
            _loc_14 = m_u.x * (_loc_12 - _loc_10) + m_u.y * (_loc_13 - _loc_11);
            _loc_15 = (-m_mass) * (_loc_14 + m_bias + m_gamma * m_impulse);
            m_impulse = m_impulse + _loc_15;
            _loc_16 = _loc_15 * m_u.x;
            _loc_17 = _loc_15 * m_u.y;
            _loc_3.m_linearVelocity.x = _loc_3.m_linearVelocity.x - _loc_3.m_invMass * _loc_16;
            _loc_3.m_linearVelocity.y = _loc_3.m_linearVelocity.y - _loc_3.m_invMass * _loc_17;
            _loc_3.m_angularVelocity = _loc_3.m_angularVelocity - _loc_3.m_invI * (_loc_5 * _loc_17 - _loc_6 * _loc_16);
            _loc_4.m_linearVelocity.x = _loc_4.m_linearVelocity.x + _loc_4.m_invMass * _loc_16;
            _loc_4.m_linearVelocity.y = _loc_4.m_linearVelocity.y + _loc_4.m_invMass * _loc_17;
            _loc_4.m_angularVelocity = _loc_4.m_angularVelocity + _loc_4.m_invI * (_loc_8 * _loc_17 - _loc_9 * _loc_16);
            return;
        }// end function

    }
}
