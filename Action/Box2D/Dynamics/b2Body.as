package Box2D.Dynamics
{
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Contacts.*;
    import Box2D.Dynamics.Joints.*;

    public class b2Body extends Object
    {
        public var m_next:b2Body;
        public var m_contactList:b2ContactEdge;
        public var m_angularVelocity:Number;
        public var m_shapeList:b2Shape;
        public var m_force:b2Vec2;
        public var m_mass:Number;
        public var m_sweep:b2Sweep;
        public var m_xf:b2XForm;
        public var m_torque:Number;
        public var m_userData:Object;
        public var m_flags:uint;
        public var m_world:b2World;
        public var m_prev:b2Body;
        public var m_invMass:Number;
        public var m_type:int;
        public var m_linearDamping:Number;
        public var m_angularDamping:Number;
        public var m_invI:Number;
        public var m_linearVelocity:b2Vec2;
        public var m_sleepTime:Number;
        public var m_shapeCount:int;
        public var m_jointList:b2JointEdge;
        public var m_I:Number;
        public static var e_fixedRotationFlag:uint = 64;
        public static var e_frozenFlag:uint = 2;
        public static var e_maxTypes:uint = 3;
        public static var e_sleepFlag:uint = 8;
        private static var s_massData:b2MassData = new b2MassData();
        public static var e_bulletFlag:uint = 32;
        public static var e_staticType:uint = 1;
        public static var e_islandFlag:uint = 4;
        public static var e_allowSleepFlag:uint = 16;
        private static var s_xf1:b2XForm = new b2XForm();
        public static var e_dynamicType:uint = 2;

        public function b2Body(param1:b2BodyDef, param2:b2World)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            m_xf = new b2XForm();
            m_sweep = new b2Sweep();
            m_linearVelocity = new b2Vec2();
            m_force = new b2Vec2();
            m_flags = 0;
            if (param1.isBullet)
            {
                m_flags = m_flags | e_bulletFlag;
            }
            if (param1.fixedRotation)
            {
                m_flags = m_flags | e_fixedRotationFlag;
            }
            if (param1.allowSleep)
            {
                m_flags = m_flags | e_allowSleepFlag;
            }
            if (param1.isSleeping)
            {
                m_flags = m_flags | e_sleepFlag;
            }
            m_world = param2;
            m_xf.position.SetV(param1.position);
            m_xf.R.Set(param1.angle);
            m_sweep.localCenter.SetV(param1.massData.center);
            m_sweep.t0 = 1;
            var _loc_5:* = param1.angle;
            m_sweep.a = param1.angle;
            m_sweep.a0 = _loc_5;
            _loc_3 = m_xf.R;
            _loc_4 = m_sweep.localCenter;
            m_sweep.c.x = _loc_3.col1.x * _loc_4.x + _loc_3.col2.x * _loc_4.y;
            m_sweep.c.y = _loc_3.col1.y * _loc_4.x + _loc_3.col2.y * _loc_4.y;
            m_sweep.c.x = m_sweep.c.x + m_xf.position.x;
            m_sweep.c.y = m_sweep.c.y + m_xf.position.y;
            m_sweep.c0.SetV(m_sweep.c);
            m_jointList = null;
            m_contactList = null;
            m_prev = null;
            m_next = null;
            m_linearDamping = param1.linearDamping;
            m_angularDamping = param1.angularDamping;
            m_force.Set(0, 0);
            m_torque = 0;
            m_linearVelocity.SetZero();
            m_angularVelocity = 0;
            m_sleepTime = 0;
            m_invMass = 0;
            m_I = 0;
            m_invI = 0;
            m_mass = param1.massData.mass;
            if (m_mass > 0)
            {
                m_invMass = 1 / m_mass;
            }
            if ((m_flags & b2Body.e_fixedRotationFlag) == 0)
            {
                m_I = param1.massData.I;
            }
            if (m_I > 0)
            {
                m_invI = 1 / m_I;
            }
            if (m_invMass == 0 && m_invI == 0)
            {
                m_type = e_staticType;
            }
            else
            {
                m_type = e_dynamicType;
            }
            m_userData = param1.userData;
            m_shapeList = null;
            m_shapeCount = 0;
            return;
        }// end function

        public function GetLinearVelocityFromWorldPoint(param1:b2Vec2) : b2Vec2
        {
            return new b2Vec2(m_linearVelocity.x + m_angularVelocity * (param1.y - m_sweep.c.y), m_linearVelocity.x - m_angularVelocity * (param1.x - m_sweep.c.x));
        }// end function

        public function SetLinearVelocity(param1:b2Vec2) : void
        {
            m_linearVelocity.SetV(param1);
            return;
        }// end function

        public function WakeUp() : void
        {
            m_flags = m_flags & ~e_sleepFlag;
            m_sleepTime = 0;
            return;
        }// end function

        public function GetLocalCenter() : b2Vec2
        {
            return m_sweep.localCenter;
        }// end function

        public function ApplyTorque(param1:Number) : void
        {
            if (IsSleeping())
            {
                WakeUp();
            }
            m_torque = m_torque + param1;
            return;
        }// end function

        public function IsFrozen() : Boolean
        {
            return (m_flags & e_frozenFlag) == e_frozenFlag;
        }// end function

        public function IsDynamic() : Boolean
        {
            return m_type == e_dynamicType;
        }// end function

        public function GetLinearVelocity() : b2Vec2
        {
            return m_linearVelocity;
        }// end function

        public function SynchronizeTransform() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            m_xf.R.Set(m_sweep.a);
            _loc_1 = m_xf.R;
            _loc_2 = m_sweep.localCenter;
            m_xf.position.x = m_sweep.c.x - (_loc_1.col1.x * _loc_2.x + _loc_1.col2.x * _loc_2.y);
            m_xf.position.y = m_sweep.c.y - (_loc_1.col1.y * _loc_2.x + _loc_1.col2.y * _loc_2.y);
            return;
        }// end function

        public function GetInertia() : Number
        {
            return m_I;
        }// end function

        public function IsSleeping() : Boolean
        {
            return (m_flags & e_sleepFlag) == e_sleepFlag;
        }// end function

        public function SetMassFromShapes() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            if (m_world.m_lock == true)
            {
                return;
            }
            m_mass = 0;
            m_invMass = 0;
            m_I = 0;
            m_invI = 0;
            _loc_2 = 0;
            _loc_3 = 0;
            _loc_4 = s_massData;
            _loc_1 = m_shapeList;
            while (_loc_1)
            {
                
                _loc_1.ComputeMass(_loc_4);
                m_mass = m_mass + _loc_4.mass;
                _loc_2 = _loc_2 + _loc_4.mass * _loc_4.center.x;
                _loc_3 = _loc_3 + _loc_4.mass * _loc_4.center.y;
                m_I = m_I + _loc_4.I;
                _loc_1 = _loc_1.m_next;
            }
            if (m_mass > 0)
            {
                m_invMass = 1 / m_mass;
                _loc_2 = _loc_2 * m_invMass;
                _loc_3 = _loc_3 * m_invMass;
            }
            if (m_I > 0 && (m_flags & e_fixedRotationFlag) == 0)
            {
                m_I = m_I - m_mass * (_loc_2 * _loc_2 + _loc_3 * _loc_3);
                m_invI = 1 / m_I;
            }
            else
            {
                m_I = 0;
                m_invI = 0;
            }
            m_sweep.localCenter.Set(_loc_2, _loc_3);
            _loc_5 = m_xf.R;
            _loc_6 = m_sweep.localCenter;
            m_sweep.c.x = _loc_5.col1.x * _loc_6.x + _loc_5.col2.x * _loc_6.y;
            m_sweep.c.y = _loc_5.col1.y * _loc_6.x + _loc_5.col2.y * _loc_6.y;
            m_sweep.c.x = m_sweep.c.x + m_xf.position.x;
            m_sweep.c.y = m_sweep.c.y + m_xf.position.y;
            m_sweep.c0.SetV(m_sweep.c);
            _loc_1 = m_shapeList;
            while (_loc_1)
            {
                
                _loc_1.UpdateSweepRadius(m_sweep.localCenter);
                _loc_1 = _loc_1.m_next;
            }
            _loc_7 = m_type;
            if (m_invMass == 0 && m_invI == 0)
            {
                m_type = e_staticType;
            }
            else
            {
                m_type = e_dynamicType;
            }
            if (_loc_7 != m_type)
            {
                _loc_1 = m_shapeList;
                while (_loc_1)
                {
                    
                    _loc_1.RefilterProxy(m_world.m_broadPhase, m_xf);
                    _loc_1 = _loc_1.m_next;
                }
            }
            return;
        }// end function

        public function PutToSleep() : void
        {
            m_flags = m_flags | e_sleepFlag;
            m_sleepTime = 0;
            m_linearVelocity.SetZero();
            m_angularVelocity = 0;
            m_force.SetZero();
            m_torque = 0;
            return;
        }// end function

        public function GetJointList() : b2JointEdge
        {
            return m_jointList;
        }// end function

        public function SetXForm(param1:b2Vec2, param2:Number) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = false;
            var _loc_7:* = false;
            if (m_world.m_lock == true)
            {
                return true;
            }
            if (IsFrozen())
            {
                return false;
            }
            m_xf.R.Set(param2);
            m_xf.position.SetV(param1);
            _loc_4 = m_xf.R;
            _loc_5 = m_sweep.localCenter;
            m_sweep.c.x = _loc_4.col1.x * _loc_5.x + _loc_4.col2.x * _loc_5.y;
            m_sweep.c.y = _loc_4.col1.y * _loc_5.x + _loc_4.col2.y * _loc_5.y;
            m_sweep.c.x = m_sweep.c.x + m_xf.position.x;
            m_sweep.c.y = m_sweep.c.y + m_xf.position.y;
            m_sweep.c0.SetV(m_sweep.c);
            var _loc_8:* = param2;
            m_sweep.a = param2;
            m_sweep.a0 = _loc_8;
            _loc_6 = false;
            _loc_3 = m_shapeList;
            while (_loc_3)
            {
                
                _loc_7 = _loc_3.Synchronize(m_world.m_broadPhase, m_xf, m_xf);
                if (_loc_7 == false)
                {
                    _loc_6 = true;
                    break;
                }
                _loc_3 = _loc_3.m_next;
            }
            if (_loc_6 == true)
            {
                m_flags = m_flags | e_frozenFlag;
                m_linearVelocity.SetZero();
                m_angularVelocity = 0;
                _loc_3 = m_shapeList;
                while (_loc_3)
                {
                    
                    _loc_3.DestroyProxy(m_world.m_broadPhase);
                    _loc_3 = _loc_3.m_next;
                }
                return false;
            }
            m_world.m_broadPhase.Commit();
            return true;
        }// end function

        public function GetLocalPoint(param1:b2Vec2) : b2Vec2
        {
            return b2Math.b2MulXT(m_xf, param1);
        }// end function

        public function ApplyForce(param1:b2Vec2, param2:b2Vec2) : void
        {
            if (IsSleeping())
            {
                WakeUp();
            }
            m_force.x = m_force.x + param1.x;
            m_force.y = m_force.y + param1.y;
            m_torque = m_torque + ((param2.x - m_sweep.c.x) * param1.y - (param2.y - m_sweep.c.y) * param1.x);
            return;
        }// end function

        public function SynchronizeShapes() : Boolean
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = false;
            _loc_1 = s_xf1;
            _loc_1.R.Set(m_sweep.a0);
            _loc_2 = _loc_1.R;
            _loc_3 = m_sweep.localCenter;
            _loc_1.position.x = m_sweep.c0.x - (_loc_2.col1.x * _loc_3.x + _loc_2.col2.x * _loc_3.y);
            _loc_1.position.y = m_sweep.c0.y - (_loc_2.col1.y * _loc_3.x + _loc_2.col2.y * _loc_3.y);
            _loc_5 = true;
            _loc_4 = m_shapeList;
            while (_loc_4)
            {
                
                _loc_5 = _loc_4.Synchronize(m_world.m_broadPhase, _loc_1, m_xf);
                if (_loc_5 == false)
                {
                    break;
                }
                _loc_4 = _loc_4.m_next;
            }
            if (_loc_5 == false)
            {
                m_flags = m_flags | e_frozenFlag;
                m_linearVelocity.SetZero();
                m_angularVelocity = 0;
                _loc_4 = m_shapeList;
                while (_loc_4)
                {
                    
                    _loc_4.DestroyProxy(m_world.m_broadPhase);
                    _loc_4 = _loc_4.m_next;
                }
                return false;
            }
            return true;
        }// end function

        public function GetAngle() : Number
        {
            return m_sweep.a;
        }// end function

        public function GetXForm() : b2XForm
        {
            return m_xf;
        }// end function

        public function ApplyImpulse(param1:b2Vec2, param2:b2Vec2) : void
        {
            if (IsSleeping())
            {
                WakeUp();
            }
            m_linearVelocity.x = m_linearVelocity.x + m_invMass * param1.x;
            m_linearVelocity.y = m_linearVelocity.y + m_invMass * param1.y;
            m_angularVelocity = m_angularVelocity + m_invI * ((param2.x - m_sweep.c.x) * param1.y - (param2.y - m_sweep.c.y) * param1.x);
            return;
        }// end function

        public function GetNext() : b2Body
        {
            return m_next;
        }// end function

        public function GetMass() : Number
        {
            return m_mass;
        }// end function

        public function GetLinearVelocityFromLocalPoint(param1:b2Vec2) : b2Vec2
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            _loc_2 = m_xf.R;
            _loc_3 = new b2Vec2(_loc_2.col1.x * param1.x + _loc_2.col2.x * param1.y, _loc_2.col1.y * param1.x + _loc_2.col2.y * param1.y);
            _loc_3.x = _loc_3.x + m_xf.position.x;
            _loc_3.y = _loc_3.y + m_xf.position.y;
            return new b2Vec2(m_linearVelocity.x + m_angularVelocity * (_loc_3.y - m_sweep.c.y), m_linearVelocity.x - m_angularVelocity * (_loc_3.x - m_sweep.c.x));
        }// end function

        public function GetAngularVelocity() : Number
        {
            return m_angularVelocity;
        }// end function

        public function SetAngularVelocity(param1:Number) : void
        {
            m_angularVelocity = param1;
            return;
        }// end function

        public function SetMass(param1:b2MassData) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (m_world.m_lock == true)
            {
                return;
            }
            m_invMass = 0;
            m_I = 0;
            m_invI = 0;
            m_mass = param1.mass;
            if (m_mass > 0)
            {
                m_invMass = 1 / m_mass;
            }
            if ((m_flags & b2Body.e_fixedRotationFlag) == 0)
            {
                m_I = param1.I;
            }
            if (m_I > 0)
            {
                m_invI = 1 / m_I;
            }
            m_sweep.localCenter.SetV(param1.center);
            _loc_3 = m_xf.R;
            _loc_4 = m_sweep.localCenter;
            m_sweep.c.x = _loc_3.col1.x * _loc_4.x + _loc_3.col2.x * _loc_4.y;
            m_sweep.c.y = _loc_3.col1.y * _loc_4.x + _loc_3.col2.y * _loc_4.y;
            m_sweep.c.x = m_sweep.c.x + m_xf.position.x;
            m_sweep.c.y = m_sweep.c.y + m_xf.position.y;
            m_sweep.c0.SetV(m_sweep.c);
            _loc_2 = m_shapeList;
            while (_loc_2)
            {
                
                _loc_2.UpdateSweepRadius(m_sweep.localCenter);
                _loc_2 = _loc_2.m_next;
            }
            _loc_5 = m_type;
            if (m_invMass == 0 && m_invI == 0)
            {
                m_type = e_staticType;
            }
            else
            {
                m_type = e_dynamicType;
            }
            if (_loc_5 != m_type)
            {
                _loc_2 = m_shapeList;
                while (_loc_2)
                {
                    
                    _loc_2.RefilterProxy(m_world.m_broadPhase, m_xf);
                    _loc_2 = _loc_2.m_next;
                }
            }
            return;
        }// end function

        public function IsStatic() : Boolean
        {
            return m_type == e_staticType;
        }// end function

        public function GetWorldVector(param1:b2Vec2) : b2Vec2
        {
            return b2Math.b2MulMV(m_xf.R, param1);
        }// end function

        public function GetShapeList() : b2Shape
        {
            return m_shapeList;
        }// end function

        public function Advance(param1:Number) : void
        {
            m_sweep.Advance(param1);
            m_sweep.c.SetV(m_sweep.c0);
            m_sweep.a = m_sweep.a0;
            SynchronizeTransform();
            return;
        }// end function

        public function SetBullet(param1:Boolean) : void
        {
            if (param1)
            {
                m_flags = m_flags | e_bulletFlag;
            }
            else
            {
                m_flags = m_flags & ~e_bulletFlag;
            }
            return;
        }// end function

        public function CreateShape(param1:b2ShapeDef) : b2Shape
        {
            var _loc_2:* = null;
            if (m_world.m_lock == true)
            {
                return null;
            }
            _loc_2 = b2Shape.Create(param1, m_world.m_blockAllocator);
            _loc_2.m_next = m_shapeList;
            m_shapeList = _loc_2;
            var _loc_4:* = m_shapeCount + 1;
            m_shapeCount = _loc_4;
            _loc_2.m_body = this;
            _loc_2.CreateProxy(m_world.m_broadPhase, m_xf);
            _loc_2.UpdateSweepRadius(m_sweep.localCenter);
            return _loc_2;
        }// end function

        public function IsConnected(param1:b2Body) : Boolean
        {
            var _loc_2:* = null;
            _loc_2 = m_jointList;
            while (_loc_2)
            {
                
                if (_loc_2.other == param1)
                {
                    return _loc_2.joint.m_collideConnected == false;
                }
                _loc_2 = _loc_2.next;
            }
            return false;
        }// end function

        public function DestroyShape(param1:b2Shape) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = false;
            if (m_world.m_lock == true)
            {
                return;
            }
            param1.DestroyProxy(m_world.m_broadPhase);
            _loc_2 = m_shapeList;
            _loc_3 = null;
            _loc_4 = false;
            while (_loc_2 != null)
            {
                
                if (_loc_2 == param1)
                {
                    if (_loc_3)
                    {
                        _loc_3.m_next = param1.m_next;
                    }
                    else
                    {
                        m_shapeList = param1.m_next;
                    }
                    _loc_4 = true;
                    break;
                }
                _loc_3 = _loc_2;
                _loc_2 = _loc_2.m_next;
            }
            param1.m_body = null;
            param1.m_next = null;
            var _loc_6:* = m_shapeCount - 1;
            m_shapeCount = _loc_6;
            b2Shape.Destroy(param1, m_world.m_blockAllocator);
            return;
        }// end function

        public function GetUserData()
        {
            return m_userData;
        }// end function

        public function IsBullet() : Boolean
        {
            return (m_flags & e_bulletFlag) == e_bulletFlag;
        }// end function

        public function GetWorldCenter() : b2Vec2
        {
            return m_sweep.c;
        }// end function

        public function AllowSleeping(param1:Boolean) : void
        {
            if (param1)
            {
                m_flags = m_flags | e_allowSleepFlag;
            }
            else
            {
                m_flags = m_flags & ~e_allowSleepFlag;
                WakeUp();
            }
            return;
        }// end function

        public function SetUserData(param1) : void
        {
            m_userData = param1;
            return;
        }// end function

        public function GetLocalVector(param1:b2Vec2) : b2Vec2
        {
            return b2Math.b2MulTMV(m_xf.R, param1);
        }// end function

        public function GetWorldPoint(param1:b2Vec2) : b2Vec2
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            _loc_2 = m_xf.R;
            _loc_3 = new b2Vec2(_loc_2.col1.x * param1.x + _loc_2.col2.x * param1.y, _loc_2.col1.y * param1.x + _loc_2.col2.y * param1.y);
            _loc_3.x = _loc_3.x + m_xf.position.x;
            _loc_3.y = _loc_3.y + m_xf.position.y;
            return _loc_3;
        }// end function

        public function GetWorld() : b2World
        {
            return m_world;
        }// end function

        public function GetPosition() : b2Vec2
        {
            return m_xf.position;
        }// end function

    }
}
