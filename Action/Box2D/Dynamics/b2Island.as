package Box2D.Dynamics
{
    import Box2D.Collision.*;
    import Box2D.Common.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Contacts.*;
    import Box2D.Dynamics.Joints.*;

    public class b2Island extends Object
    {
        public var m_joints:Array;
        public var m_listener:b2ContactListener;
        public var m_positionIterationCount:int;
        public var m_bodyCapacity:int;
        public var m_bodies:Array;
        public var m_jointCapacity:int;
        public var m_contactCount:int;
        public var m_contacts:Array;
        public var m_contactCapacity:int;
        public var m_jointCount:int;
        public var m_allocator:Object;
        public var m_bodyCount:int;
        private static var s_reportCR:b2ContactResult = new b2ContactResult();

        public function b2Island(param1:int, param2:int, param3:int, param4, param5:b2ContactListener)
        {
            var _loc_6:* = 0;
            m_bodyCapacity = param1;
            m_contactCapacity = param2;
            m_jointCapacity = param3;
            m_bodyCount = 0;
            m_contactCount = 0;
            m_jointCount = 0;
            m_allocator = param4;
            m_listener = param5;
            m_bodies = new Array(param1);
            _loc_6 = 0;
            while (_loc_6 < param1)
            {
                
                m_bodies[_loc_6] = null;
                _loc_6++;
            }
            m_contacts = new Array(param2);
            _loc_6 = 0;
            while (_loc_6 < param2)
            {
                
                m_contacts[_loc_6] = null;
                _loc_6++;
            }
            m_joints = new Array(param3);
            _loc_6 = 0;
            while (_loc_6 < param3)
            {
                
                m_joints[_loc_6] = null;
                _loc_6++;
            }
            m_positionIterationCount = 0;
            return;
        }// end function

        public function AddBody(param1:b2Body) : void
        {
            var _loc_2:* = m_bodyCount + 1;
            m_bodies[_loc_2] = param1;
            return;
        }// end function

        public function AddJoint(param1:b2Joint) : void
        {
            var _loc_2:* = m_jointCount + 1;
            m_joints[_loc_2] = param1;
            return;
        }// end function

        public function Report(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            if (m_listener == null)
            {
                return;
            }
            _loc_4 = 0;
            while (_loc_4 < m_contactCount)
            {
                
                _loc_5 = m_contacts[_loc_4];
                _loc_6 = param1[_loc_4];
                _loc_7 = s_reportCR;
                _loc_7.shape1 = _loc_5.m_shape1;
                _loc_7.shape2 = _loc_5.m_shape2;
                _loc_8 = _loc_7.shape1.m_body;
                _loc_9 = _loc_5.m_manifoldCount;
                _loc_10 = _loc_5.GetManifolds();
                _loc_11 = 0;
                while (_loc_11 < _loc_9)
                {
                    
                    _loc_12 = _loc_10[_loc_11];
                    _loc_7.normal.SetV(_loc_12.normal);
                    _loc_13 = 0;
                    while (_loc_13 < _loc_12.pointCount)
                    {
                        
                        _loc_14 = _loc_12.points[_loc_13];
                        _loc_15 = _loc_6.points[_loc_13];
                        _loc_7.position = _loc_8.GetWorldPoint(_loc_14.localPoint1);
                        _loc_7.normalImpulse = _loc_15.normalImpulse;
                        _loc_7.tangentImpulse = _loc_15.tangentImpulse;
                        _loc_7.id.key = _loc_14.id.key;
                        m_listener.Result(_loc_7);
                        _loc_13++;
                    }
                    _loc_11++;
                }
                _loc_4++;
            }
            return;
        }// end function

        public function Solve(param1:b2TimeStep, param2:b2Vec2, param3:Boolean, param4:Boolean) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = false;
            var _loc_11:* = false;
            var _loc_12:* = false;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            _loc_5 = 0;
            while (_loc_5 < m_bodyCount)
            {
                
                _loc_6 = m_bodies[_loc_5];
                if (_loc_6.IsStatic())
                {
                }
                else
                {
                    _loc_6.m_linearVelocity.x = _loc_6.m_linearVelocity.x + param1.dt * (param2.x + _loc_6.m_invMass * _loc_6.m_force.x);
                    _loc_6.m_linearVelocity.y = _loc_6.m_linearVelocity.y + param1.dt * (param2.y + _loc_6.m_invMass * _loc_6.m_force.y);
                    _loc_6.m_angularVelocity = _loc_6.m_angularVelocity + param1.dt * _loc_6.m_invI * _loc_6.m_torque;
                    _loc_6.m_force.SetZero();
                    _loc_6.m_torque = 0;
                    _loc_6.m_linearVelocity.Multiply(b2Math.b2Clamp(1 - param1.dt * _loc_6.m_linearDamping, 0, 1));
                    _loc_6.m_angularVelocity = _loc_6.m_angularVelocity * b2Math.b2Clamp(1 - param1.dt * _loc_6.m_angularDamping, 0, 1);
                    if (_loc_6.m_linearVelocity.LengthSquared() > b2Settings.b2_maxLinearVelocitySquared)
                    {
                        _loc_6.m_linearVelocity.Normalize();
                        _loc_6.m_linearVelocity.x = _loc_6.m_linearVelocity.x * b2Settings.b2_maxLinearVelocity;
                        _loc_6.m_linearVelocity.y = _loc_6.m_linearVelocity.y * b2Settings.b2_maxLinearVelocity;
                    }
                    if (_loc_6.m_angularVelocity * _loc_6.m_angularVelocity > b2Settings.b2_maxAngularVelocitySquared)
                    {
                        if (_loc_6.m_angularVelocity < 0)
                        {
                            _loc_6.m_angularVelocity = -b2Settings.b2_maxAngularVelocity;
                        }
                        else
                        {
                            _loc_6.m_angularVelocity = b2Settings.b2_maxAngularVelocity;
                        }
                    }
                }
                _loc_5++;
            }
            _loc_8 = new b2ContactSolver(param1, m_contacts, m_contactCount, m_allocator);
            _loc_8.InitVelocityConstraints(param1);
            _loc_5 = 0;
            while (_loc_5 < m_jointCount)
            {
                
                _loc_7 = m_joints[_loc_5];
                _loc_7.InitVelocityConstraints(param1);
                _loc_5++;
            }
            _loc_5 = 0;
            while (_loc_5 < param1.maxIterations)
            {
                
                _loc_8.SolveVelocityConstraints();
                _loc_9 = 0;
                while (_loc_9 < m_jointCount)
                {
                    
                    _loc_7 = m_joints[_loc_9];
                    _loc_7.SolveVelocityConstraints(param1);
                    _loc_9++;
                }
                _loc_5++;
            }
            _loc_8.FinalizeVelocityConstraints();
            _loc_5 = 0;
            while (_loc_5 < m_bodyCount)
            {
                
                _loc_6 = m_bodies[_loc_5];
                if (_loc_6.IsStatic())
                {
                }
                else
                {
                    _loc_6.m_sweep.c0.SetV(_loc_6.m_sweep.c);
                    _loc_6.m_sweep.a0 = _loc_6.m_sweep.a;
                    _loc_6.m_sweep.c.x = _loc_6.m_sweep.c.x + param1.dt * _loc_6.m_linearVelocity.x;
                    _loc_6.m_sweep.c.y = _loc_6.m_sweep.c.y + param1.dt * _loc_6.m_linearVelocity.y;
                    _loc_6.m_sweep.a = _loc_6.m_sweep.a + param1.dt * _loc_6.m_angularVelocity;
                    _loc_6.SynchronizeTransform();
                }
                _loc_5++;
            }
            if (param3)
            {
                _loc_5 = 0;
                while (_loc_5 < m_jointCount)
                {
                    
                    _loc_7 = m_joints[_loc_5];
                    _loc_7.InitPositionConstraints();
                    _loc_5++;
                }
                m_positionIterationCount = 0;
                while (m_positionIterationCount < param1.maxIterations)
                {
                    
                    _loc_10 = _loc_8.SolvePositionConstraints(b2Settings.b2_contactBaumgarte);
                    _loc_11 = true;
                    _loc_5 = 0;
                    while (_loc_5 < m_jointCount)
                    {
                        
                        _loc_7 = m_joints[_loc_5];
                        _loc_12 = _loc_7.SolvePositionConstraints();
                        _loc_11 = _loc_11 && _loc_12;
                        _loc_5++;
                    }
                    if (_loc_10 && _loc_11)
                    {
                        break;
                    }
                    var _loc_17:* = m_positionIterationCount + 1;
                    m_positionIterationCount = _loc_17;
                }
            }
            Report(_loc_8.m_constraints);
            if (param4)
            {
                _loc_13 = Number.MAX_VALUE;
                _loc_14 = b2Settings.b2_linearSleepTolerance * b2Settings.b2_linearSleepTolerance;
                _loc_15 = b2Settings.b2_angularSleepTolerance * b2Settings.b2_angularSleepTolerance;
                _loc_5 = 0;
                while (_loc_5 < m_bodyCount)
                {
                    
                    _loc_6 = m_bodies[_loc_5];
                    if (_loc_6.m_invMass == 0)
                    {
                    }
                    else
                    {
                        if ((_loc_6.m_flags & b2Body.e_allowSleepFlag) == 0)
                        {
                            _loc_6.m_sleepTime = 0;
                            _loc_13 = 0;
                        }
                        if ((_loc_6.m_flags & b2Body.e_allowSleepFlag) == 0 || _loc_6.m_angularVelocity * _loc_6.m_angularVelocity > _loc_15 || b2Math.b2Dot(_loc_6.m_linearVelocity, _loc_6.m_linearVelocity) > _loc_14)
                        {
                            _loc_6.m_sleepTime = 0;
                            _loc_13 = 0;
                        }
                        else
                        {
                            _loc_6.m_sleepTime = _loc_6.m_sleepTime + param1.dt;
                            _loc_13 = b2Math.b2Min(_loc_13, _loc_6.m_sleepTime);
                        }
                    }
                    _loc_5++;
                }
                if (_loc_13 >= b2Settings.b2_timeToSleep)
                {
                    _loc_5 = 0;
                    while (_loc_5 < m_bodyCount)
                    {
                        
                        _loc_6 = m_bodies[_loc_5];
                        _loc_6.m_flags = _loc_6.m_flags | b2Body.e_sleepFlag;
                        _loc_6.m_linearVelocity.SetZero();
                        _loc_6.m_angularVelocity = 0;
                        _loc_5++;
                    }
                }
            }
            return;
        }// end function

        public function AddContact(param1:b2Contact) : void
        {
            var _loc_2:* = m_contactCount + 1;
            m_contacts[_loc_2] = param1;
            return;
        }// end function

        public function Clear() : void
        {
            m_bodyCount = 0;
            m_contactCount = 0;
            m_jointCount = 0;
            return;
        }// end function

        public function SolveTOI(param1:b2TimeStep) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = null;
            var _loc_6:* = false;
            _loc_3 = new b2ContactSolver(param1, m_contacts, m_contactCount, m_allocator);
            _loc_2 = 0;
            while (_loc_2 < param1.maxIterations)
            {
                
                _loc_3.SolveVelocityConstraints();
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < m_bodyCount)
            {
                
                _loc_5 = m_bodies[_loc_2];
                if (_loc_5.IsStatic())
                {
                }
                else
                {
                    _loc_5.m_sweep.c0.SetV(_loc_5.m_sweep.c);
                    _loc_5.m_sweep.a0 = _loc_5.m_sweep.a;
                    _loc_5.m_sweep.c.x = _loc_5.m_sweep.c.x + param1.dt * _loc_5.m_linearVelocity.x;
                    _loc_5.m_sweep.c.y = _loc_5.m_sweep.c.y + param1.dt * _loc_5.m_linearVelocity.y;
                    _loc_5.m_sweep.a = _loc_5.m_sweep.a + param1.dt * _loc_5.m_angularVelocity;
                    _loc_5.SynchronizeTransform();
                }
                _loc_2++;
            }
            _loc_4 = 0.75;
            _loc_2 = 0;
            while (_loc_2 < param1.maxIterations)
            {
                
                _loc_6 = _loc_3.SolvePositionConstraints(_loc_4);
                if (_loc_6)
                {
                    break;
                }
                _loc_2++;
            }
            Report(_loc_3.m_constraints);
            return;
        }// end function

    }
}
