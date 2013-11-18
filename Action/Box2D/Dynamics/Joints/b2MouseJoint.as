package Box2D.Dynamics.Joints
{
    import Box2D.Common.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;

    public class b2MouseJoint extends b2Joint
    {
        public var m_beta:Number;
        public var m_mass:b2Mat22;
        public var m_target:b2Vec2;
        public var m_impulse:b2Vec2;
        public var m_localAnchor:b2Vec2;
        private var K1:b2Mat22;
        private var K2:b2Mat22;
        private var K:b2Mat22;
        public var m_gamma:Number;
        public var m_C:b2Vec2;
        public var m_maxForce:Number;

        public function b2MouseJoint(param1:b2MouseJointDef)
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            K = new b2Mat22();
            K1 = new b2Mat22();
            K2 = new b2Mat22();
            m_localAnchor = new b2Vec2();
            m_target = new b2Vec2();
            m_impulse = new b2Vec2();
            m_mass = new b2Mat22();
            m_C = new b2Vec2();
            super(param1);
            m_target.SetV(param1.target);
            _loc_2 = m_target.x - m_body2.m_xf.position.x;
            _loc_3 = m_target.y - m_body2.m_xf.position.y;
            _loc_4 = m_body2.m_xf.R;
            m_localAnchor.x = _loc_2 * _loc_4.col1.x + _loc_3 * _loc_4.col1.y;
            m_localAnchor.y = _loc_2 * _loc_4.col2.x + _loc_3 * _loc_4.col2.y;
            m_maxForce = param1.maxForce;
            m_impulse.SetZero();
            _loc_5 = m_body2.m_mass;
            _loc_6 = 2 * b2Settings.b2_pi * param1.frequencyHz;
            _loc_7 = 2 * _loc_5 * param1.dampingRatio * _loc_6;
            _loc_8 = param1.timeStep * _loc_5 * (_loc_6 * _loc_6);
            m_gamma = 1 / (_loc_7 + _loc_8);
            m_beta = _loc_8 / (_loc_7 + _loc_8);
            return;
        }// end function

        override public function GetAnchor1() : b2Vec2
        {
            return m_target;
        }// end function

        override public function GetAnchor2() : b2Vec2
        {
            return m_body2.GetWorldPoint(m_localAnchor);
        }// end function

        override public function GetReactionForce() : b2Vec2
        {
            return m_impulse;
        }// end function

        override public function SolvePositionConstraints() : Boolean
        {
            return true;
        }// end function

        override public function InitVelocityConstraints(param1:b2TimeStep) : void
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
            _loc_2 = m_body2;
            _loc_3 = _loc_2.m_xf.R;
            _loc_4 = m_localAnchor.x - _loc_2.m_sweep.localCenter.x;
            _loc_5 = m_localAnchor.y - _loc_2.m_sweep.localCenter.y;
            _loc_6 = _loc_3.col1.x * _loc_4 + _loc_3.col2.x * _loc_5;
            _loc_5 = _loc_3.col1.y * _loc_4 + _loc_3.col2.y * _loc_5;
            _loc_4 = _loc_6;
            _loc_7 = _loc_2.m_invMass;
            _loc_8 = _loc_2.m_invI;
            K1.col1.x = _loc_7;
            K1.col2.x = 0;
            K1.col1.y = 0;
            K1.col2.y = _loc_7;
            K2.col1.x = _loc_8 * _loc_5 * _loc_5;
            K2.col2.x = (-_loc_8) * _loc_4 * _loc_5;
            K2.col1.y = (-_loc_8) * _loc_4 * _loc_5;
            K2.col2.y = _loc_8 * _loc_4 * _loc_4;
            K.SetM(K1);
            K.AddM(K2);
            K.col1.x = K.col1.x + m_gamma;
            K.col2.y = K.col2.y + m_gamma;
            K.Invert(m_mass);
            m_C.x = _loc_2.m_sweep.c.x + _loc_4 - m_target.x;
            m_C.y = _loc_2.m_sweep.c.y + _loc_5 - m_target.y;
            _loc_2.m_angularVelocity = _loc_2.m_angularVelocity * 0.98;
            _loc_9 = param1.dt * m_impulse.x;
            _loc_10 = param1.dt * m_impulse.y;
            _loc_2.m_linearVelocity.x = _loc_2.m_linearVelocity.x + _loc_7 * _loc_9;
            _loc_2.m_linearVelocity.y = _loc_2.m_linearVelocity.y + _loc_7 * _loc_10;
            _loc_2.m_angularVelocity = _loc_2.m_angularVelocity + _loc_8 * (_loc_4 * _loc_10 - _loc_5 * _loc_9);
            return;
        }// end function

        override public function GetReactionTorque() : Number
        {
            return 0;
        }// end function

        public function SetTarget(param1:b2Vec2) : void
        {
            if (m_body2.IsSleeping())
            {
                m_body2.WakeUp();
            }
            m_target = param1;
            return;
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
            _loc_2 = m_body2;
            _loc_3 = _loc_2.m_xf.R;
            _loc_6 = m_localAnchor.x - _loc_2.m_sweep.localCenter.x;
            _loc_7 = m_localAnchor.y - _loc_2.m_sweep.localCenter.y;
            _loc_4 = _loc_3.col1.x * _loc_6 + _loc_3.col2.x * _loc_7;
            _loc_7 = _loc_3.col1.y * _loc_6 + _loc_3.col2.y * _loc_7;
            _loc_6 = _loc_4;
            _loc_8 = _loc_2.m_linearVelocity.x + (-_loc_2.m_angularVelocity) * _loc_7;
            _loc_9 = _loc_2.m_linearVelocity.y + _loc_2.m_angularVelocity * _loc_6;
            _loc_3 = m_mass;
            _loc_4 = _loc_8 + m_beta * param1.inv_dt * m_C.x + m_gamma * param1.dt * m_impulse.x;
            _loc_5 = _loc_9 + m_beta * param1.inv_dt * m_C.y + m_gamma * param1.dt * m_impulse.y;
            _loc_10 = (-param1.inv_dt) * (_loc_3.col1.x * _loc_4 + _loc_3.col2.x * _loc_5);
            _loc_11 = (-param1.inv_dt) * (_loc_3.col1.y * _loc_4 + _loc_3.col2.y * _loc_5);
            _loc_12 = m_impulse.x;
            _loc_13 = m_impulse.y;
            m_impulse.x = m_impulse.x + _loc_10;
            m_impulse.y = m_impulse.y + _loc_11;
            _loc_14 = m_impulse.Length();
            if (_loc_14 > m_maxForce)
            {
                m_impulse.Multiply(m_maxForce / _loc_14);
            }
            _loc_10 = m_impulse.x - _loc_12;
            _loc_11 = m_impulse.y - _loc_13;
            _loc_15 = param1.dt * _loc_10;
            _loc_16 = param1.dt * _loc_11;
            _loc_2.m_linearVelocity.x = _loc_2.m_linearVelocity.x + _loc_2.m_invMass * _loc_15;
            _loc_2.m_linearVelocity.y = _loc_2.m_linearVelocity.y + _loc_2.m_invMass * _loc_16;
            _loc_2.m_angularVelocity = _loc_2.m_angularVelocity + _loc_2.m_invI * (_loc_6 * _loc_16 - _loc_7 * _loc_15);
            return;
        }// end function

    }
}
