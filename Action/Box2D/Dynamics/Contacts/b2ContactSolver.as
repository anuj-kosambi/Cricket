package Box2D.Dynamics.Contacts
{
    import Box2D.Collision.*;
    import Box2D.Common.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;

    public class b2ContactSolver extends Object
    {
        public var m_constraintCount:int;
        public var m_constraints:Array;
        public var m_allocator:Object;
        public var m_step:b2TimeStep;

        public function b2ContactSolver(param1:b2TimeStep, param2:Array, param3:int, param4)
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = 0;
            var _loc_23:* = null;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            var _loc_26:* = null;
            var _loc_27:* = 0;
            var _loc_28:* = null;
            var _loc_29:* = null;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            var _loc_32:* = NaN;
            var _loc_33:* = NaN;
            var _loc_34:* = NaN;
            var _loc_35:* = NaN;
            var _loc_36:* = NaN;
            var _loc_37:* = NaN;
            var _loc_38:* = NaN;
            var _loc_39:* = NaN;
            var _loc_40:* = NaN;
            var _loc_41:* = NaN;
            var _loc_42:* = NaN;
            var _loc_43:* = NaN;
            var _loc_44:* = NaN;
            var _loc_45:* = NaN;
            var _loc_46:* = NaN;
            var _loc_47:* = NaN;
            m_step = new b2TimeStep();
            m_constraints = new Array();
            m_step.dt = param1.dt;
            m_step.inv_dt = param1.inv_dt;
            m_step.maxIterations = param1.maxIterations;
            m_allocator = param4;
            m_constraintCount = 0;
            _loc_6 = 0;
            while (_loc_6 < param3)
            {
                
                _loc_5 = param2[_loc_6];
                m_constraintCount = m_constraintCount + _loc_5.m_manifoldCount;
                _loc_6++;
            }
            _loc_6 = 0;
            while (_loc_6 < m_constraintCount)
            {
                
                m_constraints[_loc_6] = new b2ContactConstraint();
                _loc_6++;
            }
            _loc_9 = 0;
            _loc_6 = 0;
            while (_loc_6 < param3)
            {
                
                _loc_5 = param2[_loc_6];
                _loc_10 = _loc_5.m_shape1.m_body;
                _loc_11 = _loc_5.m_shape2.m_body;
                _loc_12 = _loc_5.m_manifoldCount;
                _loc_13 = _loc_5.GetManifolds();
                _loc_14 = _loc_5.m_friction;
                _loc_15 = _loc_5.m_restitution;
                _loc_16 = _loc_10.m_linearVelocity.x;
                _loc_17 = _loc_10.m_linearVelocity.y;
                _loc_18 = _loc_11.m_linearVelocity.x;
                _loc_19 = _loc_11.m_linearVelocity.y;
                _loc_20 = _loc_10.m_angularVelocity;
                _loc_21 = _loc_11.m_angularVelocity;
                _loc_22 = 0;
                while (_loc_22 < _loc_12)
                {
                    
                    _loc_23 = _loc_13[_loc_22];
                    _loc_24 = _loc_23.normal.x;
                    _loc_25 = _loc_23.normal.y;
                    _loc_26 = m_constraints[_loc_9];
                    _loc_26.body1 = _loc_10;
                    _loc_26.body2 = _loc_11;
                    _loc_26.manifold = _loc_23;
                    _loc_26.normal.x = _loc_24;
                    _loc_26.normal.y = _loc_25;
                    _loc_26.pointCount = _loc_23.pointCount;
                    _loc_26.friction = _loc_14;
                    _loc_26.restitution = _loc_15;
                    _loc_27 = 0;
                    while (_loc_27 < _loc_26.pointCount)
                    {
                        
                        _loc_28 = _loc_23.points[_loc_27];
                        _loc_29 = _loc_26.points[_loc_27];
                        _loc_29.normalImpulse = _loc_28.normalImpulse;
                        _loc_29.tangentImpulse = _loc_28.tangentImpulse;
                        _loc_29.separation = _loc_28.separation;
                        _loc_29.positionImpulse = 0;
                        _loc_29.localAnchor1.SetV(_loc_28.localPoint1);
                        _loc_29.localAnchor2.SetV(_loc_28.localPoint2);
                        _loc_8 = _loc_10.m_xf.R;
                        _loc_32 = _loc_28.localPoint1.x - _loc_10.m_sweep.localCenter.x;
                        _loc_33 = _loc_28.localPoint1.y - _loc_10.m_sweep.localCenter.y;
                        _loc_30 = _loc_8.col1.x * _loc_32 + _loc_8.col2.x * _loc_33;
                        _loc_33 = _loc_8.col1.y * _loc_32 + _loc_8.col2.y * _loc_33;
                        _loc_32 = _loc_30;
                        _loc_29.r1.Set(_loc_32, _loc_33);
                        _loc_8 = _loc_11.m_xf.R;
                        _loc_34 = _loc_28.localPoint2.x - _loc_11.m_sweep.localCenter.x;
                        _loc_35 = _loc_28.localPoint2.y - _loc_11.m_sweep.localCenter.y;
                        _loc_30 = _loc_8.col1.x * _loc_34 + _loc_8.col2.x * _loc_35;
                        _loc_35 = _loc_8.col1.y * _loc_34 + _loc_8.col2.y * _loc_35;
                        _loc_34 = _loc_30;
                        _loc_29.r2.Set(_loc_34, _loc_35);
                        _loc_36 = _loc_32 * _loc_32 + _loc_33 * _loc_33;
                        _loc_37 = _loc_34 * _loc_34 + _loc_35 * _loc_35;
                        _loc_38 = _loc_32 * _loc_24 + _loc_33 * _loc_25;
                        _loc_39 = _loc_34 * _loc_24 + _loc_35 * _loc_25;
                        _loc_40 = _loc_10.m_invMass + _loc_11.m_invMass;
                        _loc_40 = _loc_40 + (_loc_10.m_invI * (_loc_36 - _loc_38 * _loc_38) + _loc_11.m_invI * (_loc_37 - _loc_39 * _loc_39));
                        _loc_29.normalMass = 1 / _loc_40;
                        _loc_41 = _loc_10.m_mass * _loc_10.m_invMass + _loc_11.m_mass * _loc_11.m_invMass;
                        _loc_41 = _loc_41 + (_loc_10.m_mass * _loc_10.m_invI * (_loc_36 - _loc_38 * _loc_38) + _loc_11.m_mass * _loc_11.m_invI * (_loc_37 - _loc_39 * _loc_39));
                        _loc_29.equalizedMass = 1 / _loc_41;
                        _loc_42 = _loc_25;
                        _loc_43 = -_loc_24;
                        _loc_44 = _loc_32 * _loc_42 + _loc_33 * _loc_43;
                        _loc_45 = _loc_34 * _loc_42 + _loc_35 * _loc_43;
                        _loc_46 = _loc_10.m_invMass + _loc_11.m_invMass;
                        _loc_46 = _loc_46 + (_loc_10.m_invI * (_loc_36 - _loc_44 * _loc_44) + _loc_11.m_invI * (_loc_37 - _loc_45 * _loc_45));
                        _loc_29.tangentMass = 1 / _loc_46;
                        _loc_29.velocityBias = 0;
                        if (_loc_29.separation > 0)
                        {
                            _loc_29.velocityBias = -60 * _loc_29.separation;
                        }
                        _loc_30 = _loc_18 + (-_loc_21) * _loc_35 - _loc_16 - (-_loc_20) * _loc_33;
                        _loc_31 = _loc_19 + _loc_21 * _loc_34 - _loc_17 - _loc_20 * _loc_32;
                        _loc_47 = _loc_26.normal.x * _loc_30 + _loc_26.normal.y * _loc_31;
                        if (_loc_47 < -b2Settings.b2_velocityThreshold)
                        {
                            _loc_29.velocityBias = _loc_29.velocityBias + (-_loc_26.restitution) * _loc_47;
                        }
                        _loc_27 = _loc_27 + 1;
                    }
                    _loc_9++;
                    _loc_22++;
                }
                _loc_6++;
            }
            return;
        }// end function

        public function InitVelocityConstraints(param1:b2TimeStep) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = null;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = null;
            _loc_5 = 0;
            while (_loc_5 < m_constraintCount)
            {
                
                _loc_6 = m_constraints[_loc_5];
                _loc_7 = _loc_6.body1;
                _loc_8 = _loc_6.body2;
                _loc_9 = _loc_7.m_invMass;
                _loc_10 = _loc_7.m_invI;
                _loc_11 = _loc_8.m_invMass;
                _loc_12 = _loc_8.m_invI;
                _loc_13 = _loc_6.normal.x;
                _loc_14 = _loc_6.normal.y;
                _loc_15 = _loc_14;
                _loc_16 = -_loc_13;
                if (param1.warmStarting)
                {
                    _loc_19 = _loc_6.pointCount;
                    _loc_18 = 0;
                    while (_loc_18 < _loc_19)
                    {
                        
                        _loc_20 = _loc_6.points[_loc_18];
                        _loc_20.normalImpulse = _loc_20.normalImpulse * param1.dtRatio;
                        _loc_20.tangentImpulse = _loc_20.tangentImpulse * param1.dtRatio;
                        _loc_21 = _loc_20.normalImpulse * _loc_13 + _loc_20.tangentImpulse * _loc_15;
                        _loc_22 = _loc_20.normalImpulse * _loc_14 + _loc_20.tangentImpulse * _loc_16;
                        _loc_7.m_angularVelocity = _loc_7.m_angularVelocity - _loc_10 * (_loc_20.r1.x * _loc_22 - _loc_20.r1.y * _loc_21);
                        _loc_7.m_linearVelocity.x = _loc_7.m_linearVelocity.x - _loc_9 * _loc_21;
                        _loc_7.m_linearVelocity.y = _loc_7.m_linearVelocity.y - _loc_9 * _loc_22;
                        _loc_8.m_angularVelocity = _loc_8.m_angularVelocity + _loc_12 * (_loc_20.r2.x * _loc_22 - _loc_20.r2.y * _loc_21);
                        _loc_8.m_linearVelocity.x = _loc_8.m_linearVelocity.x + _loc_11 * _loc_21;
                        _loc_8.m_linearVelocity.y = _loc_8.m_linearVelocity.y + _loc_11 * _loc_22;
                        _loc_18++;
                    }
                }
                else
                {
                    _loc_19 = _loc_6.pointCount;
                    _loc_18 = 0;
                    while (_loc_18 < _loc_19)
                    {
                        
                        _loc_23 = _loc_6.points[_loc_18];
                        _loc_23.normalImpulse = 0;
                        _loc_23.tangentImpulse = 0;
                        _loc_18++;
                    }
                }
                _loc_5++;
            }
            return;
        }// end function

        public function SolvePositionConstraints(param1:Number) : Boolean
        {
            var _loc_2:* = NaN;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = NaN;
            var _loc_11:* = null;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = null;
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
            var _loc_33:* = NaN;
            var _loc_34:* = NaN;
            var _loc_35:* = NaN;
            var _loc_36:* = NaN;
            var _loc_37:* = NaN;
            var _loc_38:* = NaN;
            _loc_2 = 0;
            _loc_5 = 0;
            while (_loc_5 < m_constraintCount)
            {
                
                _loc_6 = m_constraints[_loc_5];
                _loc_7 = _loc_6.body1;
                _loc_8 = _loc_6.body2;
                _loc_9 = _loc_7.m_sweep.c;
                _loc_10 = _loc_7.m_sweep.a;
                _loc_11 = _loc_8.m_sweep.c;
                _loc_12 = _loc_8.m_sweep.a;
                _loc_13 = _loc_7.m_mass * _loc_7.m_invMass;
                _loc_14 = _loc_7.m_mass * _loc_7.m_invI;
                _loc_15 = _loc_8.m_mass * _loc_8.m_invMass;
                _loc_16 = _loc_8.m_mass * _loc_8.m_invI;
                _loc_17 = _loc_6.normal.x;
                _loc_18 = _loc_6.normal.y;
                _loc_19 = _loc_6.pointCount;
                _loc_20 = 0;
                while (_loc_20 < _loc_19)
                {
                    
                    _loc_21 = _loc_6.points[_loc_20];
                    _loc_3 = _loc_7.m_xf.R;
                    _loc_4 = _loc_7.m_sweep.localCenter;
                    _loc_22 = _loc_21.localAnchor1.x - _loc_4.x;
                    _loc_23 = _loc_21.localAnchor1.y - _loc_4.y;
                    _loc_26 = _loc_3.col1.x * _loc_22 + _loc_3.col2.x * _loc_23;
                    _loc_23 = _loc_3.col1.y * _loc_22 + _loc_3.col2.y * _loc_23;
                    _loc_22 = _loc_26;
                    _loc_3 = _loc_8.m_xf.R;
                    _loc_4 = _loc_8.m_sweep.localCenter;
                    _loc_24 = _loc_21.localAnchor2.x - _loc_4.x;
                    _loc_25 = _loc_21.localAnchor2.y - _loc_4.y;
                    _loc_26 = _loc_3.col1.x * _loc_24 + _loc_3.col2.x * _loc_25;
                    _loc_25 = _loc_3.col1.y * _loc_24 + _loc_3.col2.y * _loc_25;
                    _loc_24 = _loc_26;
                    _loc_27 = _loc_9.x + _loc_22;
                    _loc_28 = _loc_9.y + _loc_23;
                    _loc_29 = _loc_11.x + _loc_24;
                    _loc_30 = _loc_11.y + _loc_25;
                    _loc_31 = _loc_29 - _loc_27;
                    _loc_32 = _loc_30 - _loc_28;
                    _loc_33 = _loc_31 * _loc_17 + _loc_32 * _loc_18 + _loc_21.separation;
                    _loc_2 = b2Math.b2Min(_loc_2, _loc_33);
                    _loc_34 = param1 * b2Math.b2Clamp(_loc_33 + b2Settings.b2_linearSlop, -b2Settings.b2_maxLinearCorrection, 0);
                    _loc_35 = (-_loc_21.equalizedMass) * _loc_34;
                    _loc_36 = _loc_21.positionImpulse;
                    _loc_21.positionImpulse = b2Math.b2Max(_loc_36 + _loc_35, 0);
                    _loc_35 = _loc_21.positionImpulse - _loc_36;
                    _loc_37 = _loc_35 * _loc_17;
                    _loc_38 = _loc_35 * _loc_18;
                    _loc_9.x = _loc_9.x - _loc_13 * _loc_37;
                    _loc_9.y = _loc_9.y - _loc_13 * _loc_38;
                    _loc_10 = _loc_10 - _loc_14 * (_loc_22 * _loc_38 - _loc_23 * _loc_37);
                    _loc_7.m_sweep.a = _loc_10;
                    _loc_7.SynchronizeTransform();
                    _loc_11.x = _loc_11.x + _loc_15 * _loc_37;
                    _loc_11.y = _loc_11.y + _loc_15 * _loc_38;
                    _loc_12 = _loc_12 + _loc_16 * (_loc_24 * _loc_38 - _loc_25 * _loc_37);
                    _loc_8.m_sweep.a = _loc_12;
                    _loc_8.SynchronizeTransform();
                    _loc_20++;
                }
                _loc_5++;
            }
            return _loc_2 >= -1.5 * b2Settings.b2_linearSlop;
        }// end function

        public function SolveVelocityConstraints() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = NaN;
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
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = 0;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = NaN;
            var _loc_28:* = NaN;
            var _loc_29:* = NaN;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            var _loc_32:* = NaN;
            var _loc_33:* = NaN;
            var _loc_34:* = NaN;
            var _loc_35:* = NaN;
            var _loc_36:* = NaN;
            var _loc_37:* = 0;
            var _loc_38:* = NaN;
            _loc_19 = 0;
            while (_loc_19 < m_constraintCount)
            {
                
                _loc_20 = m_constraints[_loc_19];
                _loc_21 = _loc_20.body1;
                _loc_22 = _loc_20.body2;
                _loc_23 = _loc_21.m_angularVelocity;
                _loc_24 = _loc_22.m_angularVelocity;
                _loc_25 = _loc_21.m_linearVelocity;
                _loc_26 = _loc_22.m_linearVelocity;
                _loc_27 = _loc_21.m_invMass;
                _loc_28 = _loc_21.m_invI;
                _loc_29 = _loc_22.m_invMass;
                _loc_30 = _loc_22.m_invI;
                _loc_31 = _loc_20.normal.x;
                _loc_32 = _loc_20.normal.y;
                _loc_33 = _loc_32;
                _loc_34 = -_loc_31;
                _loc_35 = _loc_20.friction;
                _loc_37 = _loc_20.pointCount;
                _loc_1 = 0;
                while (_loc_1 < _loc_37)
                {
                    
                    _loc_2 = _loc_20.points[_loc_1];
                    _loc_7 = _loc_26.x + (-_loc_24) * _loc_2.r2.y - _loc_25.x - (-_loc_23) * _loc_2.r1.y;
                    _loc_8 = _loc_26.y + _loc_24 * _loc_2.r2.x - _loc_25.y - _loc_23 * _loc_2.r1.x;
                    _loc_9 = _loc_7 * _loc_31 + _loc_8 * _loc_32;
                    _loc_11 = (-_loc_2.normalMass) * (_loc_9 - _loc_2.velocityBias);
                    _loc_10 = _loc_7 * _loc_33 + _loc_8 * _loc_34;
                    _loc_12 = _loc_2.tangentMass * (-_loc_10);
                    _loc_13 = b2Math.b2Max(_loc_2.normalImpulse + _loc_11, 0);
                    _loc_11 = _loc_13 - _loc_2.normalImpulse;
                    _loc_38 = _loc_35 * _loc_2.normalImpulse;
                    _loc_14 = b2Math.b2Clamp(_loc_2.tangentImpulse + _loc_12, -_loc_38, _loc_38);
                    _loc_12 = _loc_14 - _loc_2.tangentImpulse;
                    _loc_15 = _loc_11 * _loc_31 + _loc_12 * _loc_33;
                    _loc_16 = _loc_11 * _loc_32 + _loc_12 * _loc_34;
                    _loc_25.x = _loc_25.x - _loc_27 * _loc_15;
                    _loc_25.y = _loc_25.y - _loc_27 * _loc_16;
                    _loc_23 = _loc_23 - _loc_28 * (_loc_2.r1.x * _loc_16 - _loc_2.r1.y * _loc_15);
                    _loc_26.x = _loc_26.x + _loc_29 * _loc_15;
                    _loc_26.y = _loc_26.y + _loc_29 * _loc_16;
                    _loc_24 = _loc_24 + _loc_30 * (_loc_2.r2.x * _loc_16 - _loc_2.r2.y * _loc_15);
                    _loc_2.normalImpulse = _loc_13;
                    _loc_2.tangentImpulse = _loc_14;
                    _loc_1++;
                }
                _loc_21.m_angularVelocity = _loc_23;
                _loc_22.m_angularVelocity = _loc_24;
                _loc_19++;
            }
            return;
        }// end function

        public function FinalizeVelocityConstraints() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            _loc_1 = 0;
            while (_loc_1 < m_constraintCount)
            {
                
                _loc_2 = m_constraints[_loc_1];
                _loc_3 = _loc_2.manifold;
                _loc_4 = 0;
                while (_loc_4 < _loc_2.pointCount)
                {
                    
                    _loc_5 = _loc_3.points[_loc_4];
                    _loc_6 = _loc_2.points[_loc_4];
                    _loc_5.normalImpulse = _loc_6.normalImpulse;
                    _loc_5.tangentImpulse = _loc_6.tangentImpulse;
                    _loc_4++;
                }
                _loc_1++;
            }
            return;
        }// end function

    }
}
