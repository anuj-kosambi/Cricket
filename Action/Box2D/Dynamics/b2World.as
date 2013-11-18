package Box2D.Dynamics
{
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Contacts.*;
    import Box2D.Dynamics.Joints.*;

    public class b2World extends Object
    {
        public var m_inv_dt0:Number;
        public var m_boundaryListener:b2BoundaryListener;
        public var m_contactList:b2Contact;
        public var m_blockAllocator:Object;
        public var m_contactListener:b2ContactListener;
        public var m_allowSleep:Boolean;
        public var m_broadPhase:b2BroadPhase;
        public var m_destructionListener:b2DestructionListener;
        public var m_jointCount:int;
        public var m_bodyCount:int;
        public var m_lock:Boolean;
        public var m_positionIterationCount:int;
        public var m_groundBody:b2Body;
        public var m_contactCount:int;
        public var m_debugDraw:b2DebugDraw;
        public var m_contactFilter:b2ContactFilter;
        public var m_bodyList:b2Body;
        public var m_stackAllocator:Object;
        public var m_jointList:b2Joint;
        public var m_gravity:b2Vec2;
        public var m_contactManager:b2ContactManager;
        private static var s_jointColor:b2Color = new b2Color(0.5, 0.8, 0.8);
        public static var m_continuousPhysics:Boolean;
        public static var m_warmStarting:Boolean;
        private static var s_coreColor:b2Color = new b2Color(0.9, 0.6, 0.6);
        public static var m_positionCorrection:Boolean;
        private static var s_xf:b2XForm = new b2XForm();

        public function b2World(param1:b2AABB, param2:b2Vec2, param3:Boolean)
        {
            var _loc_4:* = null;
            m_contactManager = new b2ContactManager();
            m_destructionListener = null;
            m_boundaryListener = null;
            m_contactFilter = b2ContactFilter.b2_defaultFilter;
            m_contactListener = null;
            m_debugDraw = null;
            m_bodyList = null;
            m_contactList = null;
            m_jointList = null;
            m_bodyCount = 0;
            m_contactCount = 0;
            m_jointCount = 0;
            m_positionCorrection = true;
            m_warmStarting = true;
            m_continuousPhysics = true;
            m_allowSleep = param3;
            m_gravity = param2;
            m_lock = false;
            m_inv_dt0 = 0;
            m_contactManager.m_world = this;
            m_broadPhase = new b2BroadPhase(param1, m_contactManager);
            _loc_4 = new b2BodyDef();
            m_groundBody = CreateBody(_loc_4);
            return;
        }// end function

        public function DrawJoint(param1:b2Joint) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            _loc_2 = param1.m_body1;
            _loc_3 = param1.m_body2;
            _loc_4 = _loc_2.m_xf;
            _loc_5 = _loc_3.m_xf;
            _loc_6 = _loc_4.position;
            _loc_7 = _loc_5.position;
            _loc_8 = param1.GetAnchor1();
            _loc_9 = param1.GetAnchor2();
            _loc_10 = s_jointColor;
            switch(param1.m_type)
            {
                case b2Joint.e_distanceJoint:
                {
                    m_debugDraw.DrawSegment(_loc_8, _loc_9, _loc_10);
                    break;
                }
                case b2Joint.e_pulleyJoint:
                {
                    _loc_11 = param1 as b2PulleyJoint;
                    _loc_12 = _loc_11.GetGroundAnchor1();
                    _loc_13 = _loc_11.GetGroundAnchor2();
                    m_debugDraw.DrawSegment(_loc_12, _loc_8, _loc_10);
                    m_debugDraw.DrawSegment(_loc_13, _loc_9, _loc_10);
                    m_debugDraw.DrawSegment(_loc_12, _loc_13, _loc_10);
                    break;
                }
                case b2Joint.e_mouseJoint:
                {
                    m_debugDraw.DrawSegment(_loc_8, _loc_9, _loc_10);
                    break;
                }
                default:
                {
                    if (_loc_2 != m_groundBody)
                    {
                        m_debugDraw.DrawSegment(_loc_6, _loc_8, _loc_10);
                    }
                    m_debugDraw.DrawSegment(_loc_8, _loc_9, _loc_10);
                    if (_loc_3 != m_groundBody)
                    {
                        m_debugDraw.DrawSegment(_loc_7, _loc_9, _loc_10);
                    }
                    break;
                }
            }
            return;
        }// end function

        public function Refilter(param1:b2Shape) : void
        {
            param1.RefilterProxy(m_broadPhase, param1.m_body.m_xf);
            return;
        }// end function

        public function SetDebugDraw(param1:b2DebugDraw) : void
        {
            m_debugDraw = param1;
            return;
        }// end function

        public function SetContinuousPhysics(param1:Boolean) : void
        {
            m_continuousPhysics = param1;
            return;
        }// end function

        public function GetProxyCount() : int
        {
            return m_broadPhase.m_proxyCount;
        }// end function

        public function DrawDebugData() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = false;
            var _loc_16:* = 0;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = NaN;
            if (m_debugDraw == null)
            {
                return;
            }
            m_debugDraw.m_sprite.graphics.clear();
            _loc_1 = m_debugDraw.GetFlags();
            _loc_7 = new b2Vec2();
            _loc_8 = new b2Vec2();
            _loc_9 = new b2Vec2();
            _loc_10 = new b2Color(0, 0, 0);
            _loc_12 = new b2AABB();
            _loc_13 = new b2AABB();
            _loc_14 = [new b2Vec2(), new b2Vec2(), new b2Vec2(), new b2Vec2()];
            if (_loc_1 & b2DebugDraw.e_shapeBit)
            {
                _loc_15 = (_loc_1 & b2DebugDraw.e_coreShapeBit) == b2DebugDraw.e_coreShapeBit;
                _loc_3 = m_bodyList;
                while (_loc_3)
                {
                    
                    _loc_11 = _loc_3.m_xf;
                    _loc_4 = _loc_3.GetShapeList();
                    while (_loc_4)
                    {
                        
                        if (_loc_3.IsStatic())
                        {
                            DrawShape(_loc_4, _loc_11, new b2Color(0.5, 0.9, 0.5), _loc_15);
                        }
                        else if (_loc_3.IsSleeping())
                        {
                            DrawShape(_loc_4, _loc_11, new b2Color(0.5, 0.5, 0.9), _loc_15);
                        }
                        else
                        {
                            DrawShape(_loc_4, _loc_11, new b2Color(0.9, 0.9, 0.9), _loc_15);
                        }
                        _loc_4 = _loc_4.m_next;
                    }
                    _loc_3 = _loc_3.m_next;
                }
            }
            if (_loc_1 & b2DebugDraw.e_jointBit)
            {
                _loc_5 = m_jointList;
                while (_loc_5)
                {
                    
                    DrawJoint(_loc_5);
                    _loc_5 = _loc_5.m_next;
                }
            }
            if (_loc_1 & b2DebugDraw.e_pairBit)
            {
                _loc_6 = m_broadPhase;
                _loc_7.Set(1 / _loc_6.m_quantizationFactor.x, 1 / _loc_6.m_quantizationFactor.y);
                _loc_10.Set(0.9, 0.9, 0.3);
                _loc_2 = 0;
                while (_loc_2 < b2Pair.b2_tableCapacity)
                {
                    
                    _loc_16 = _loc_6.m_pairManager.m_hashTable[_loc_2];
                    while (_loc_16 != b2Pair.b2_nullPair)
                    {
                        
                        _loc_17 = _loc_6.m_pairManager.m_pairs[_loc_16];
                        _loc_18 = _loc_6.m_proxyPool[_loc_17.proxyId1];
                        _loc_19 = _loc_6.m_proxyPool[_loc_17.proxyId2];
                        _loc_12.lowerBound.x = _loc_6.m_worldAABB.lowerBound.x + _loc_7.x * _loc_6.m_bounds[0][_loc_18.lowerBounds[0]].value;
                        _loc_12.lowerBound.y = _loc_6.m_worldAABB.lowerBound.y + _loc_7.y * _loc_6.m_bounds[1][_loc_18.lowerBounds[1]].value;
                        _loc_12.upperBound.x = _loc_6.m_worldAABB.lowerBound.x + _loc_7.x * _loc_6.m_bounds[0][_loc_18.upperBounds[0]].value;
                        _loc_12.upperBound.y = _loc_6.m_worldAABB.lowerBound.y + _loc_7.y * _loc_6.m_bounds[1][_loc_18.upperBounds[1]].value;
                        _loc_13.lowerBound.x = _loc_6.m_worldAABB.lowerBound.x + _loc_7.x * _loc_6.m_bounds[0][_loc_19.lowerBounds[0]].value;
                        _loc_13.lowerBound.y = _loc_6.m_worldAABB.lowerBound.y + _loc_7.y * _loc_6.m_bounds[1][_loc_19.lowerBounds[1]].value;
                        _loc_13.upperBound.x = _loc_6.m_worldAABB.lowerBound.x + _loc_7.x * _loc_6.m_bounds[0][_loc_19.upperBounds[0]].value;
                        _loc_13.upperBound.y = _loc_6.m_worldAABB.lowerBound.y + _loc_7.y * _loc_6.m_bounds[1][_loc_19.upperBounds[1]].value;
                        _loc_8.x = 0.5 * (_loc_12.lowerBound.x + _loc_12.upperBound.x);
                        _loc_8.y = 0.5 * (_loc_12.lowerBound.y + _loc_12.upperBound.y);
                        _loc_9.x = 0.5 * (_loc_13.lowerBound.x + _loc_13.upperBound.x);
                        _loc_9.y = 0.5 * (_loc_13.lowerBound.y + _loc_13.upperBound.y);
                        m_debugDraw.DrawSegment(_loc_8, _loc_9, _loc_10);
                        _loc_16 = _loc_17.next;
                    }
                    _loc_2++;
                }
            }
            if (_loc_1 & b2DebugDraw.e_aabbBit)
            {
                _loc_6 = m_broadPhase;
                _loc_20 = _loc_6.m_worldAABB.lowerBound;
                _loc_21 = _loc_6.m_worldAABB.upperBound;
                _loc_7.Set(1 / _loc_6.m_quantizationFactor.x, 1 / _loc_6.m_quantizationFactor.y);
                _loc_10.Set(0.9, 0.3, 0.9);
                _loc_2 = 0;
                while (_loc_2 < b2Settings.b2_maxProxies)
                {
                    
                    _loc_22 = _loc_6.m_proxyPool[_loc_2];
                    if (_loc_22.IsValid() == false)
                    {
                    }
                    else
                    {
                        _loc_12.lowerBound.x = _loc_20.x + _loc_7.x * _loc_6.m_bounds[0][_loc_22.lowerBounds[0]].value;
                        _loc_12.lowerBound.y = _loc_20.y + _loc_7.y * _loc_6.m_bounds[1][_loc_22.lowerBounds[1]].value;
                        _loc_12.upperBound.x = _loc_20.x + _loc_7.x * _loc_6.m_bounds[0][_loc_22.upperBounds[0]].value;
                        _loc_12.upperBound.y = _loc_20.y + _loc_7.y * _loc_6.m_bounds[1][_loc_22.upperBounds[1]].value;
                        _loc_14[0].Set(_loc_12.lowerBound.x, _loc_12.lowerBound.y);
                        _loc_14[1].Set(_loc_12.upperBound.x, _loc_12.lowerBound.y);
                        _loc_14[2].Set(_loc_12.upperBound.x, _loc_12.upperBound.y);
                        _loc_14[3].Set(_loc_12.lowerBound.x, _loc_12.upperBound.y);
                        m_debugDraw.DrawPolygon(_loc_14, 4, _loc_10);
                    }
                    _loc_2++;
                }
                _loc_14[0].Set(_loc_20.x, _loc_20.y);
                _loc_14[1].Set(_loc_21.x, _loc_20.y);
                _loc_14[2].Set(_loc_21.x, _loc_21.y);
                _loc_14[3].Set(_loc_20.x, _loc_21.y);
                m_debugDraw.DrawPolygon(_loc_14, 4, new b2Color(0.3, 0.9, 0.9));
            }
            if (_loc_1 & b2DebugDraw.e_obbBit)
            {
                _loc_10.Set(0.5, 0.3, 0.5);
                _loc_3 = m_bodyList;
                while (_loc_3)
                {
                    
                    _loc_11 = _loc_3.m_xf;
                    _loc_4 = _loc_3.GetShapeList();
                    while (_loc_4)
                    {
                        
                        if (_loc_4.m_type != b2Shape.e_polygonShape)
                        {
                        }
                        else
                        {
                            _loc_23 = _loc_4 as b2PolygonShape;
                            _loc_24 = _loc_23.GetOBB();
                            _loc_25 = _loc_24.extents;
                            _loc_14[0].Set(-_loc_25.x, -_loc_25.y);
                            _loc_14[1].Set(_loc_25.x, -_loc_25.y);
                            _loc_14[2].Set(_loc_25.x, _loc_25.y);
                            _loc_14[3].Set(-_loc_25.x, _loc_25.y);
                            _loc_2 = 0;
                            while (_loc_2 < 4)
                            {
                                
                                _loc_26 = _loc_24.R;
                                _loc_27 = _loc_14[_loc_2];
                                _loc_28 = _loc_24.center.x + (_loc_26.col1.x * _loc_27.x + _loc_26.col2.x * _loc_27.y);
                                _loc_27.y = _loc_24.center.y + (_loc_26.col1.y * _loc_27.x + _loc_26.col2.y * _loc_27.y);
                                _loc_27.x = _loc_28;
                                _loc_26 = _loc_11.R;
                                _loc_28 = _loc_11.position.x + (_loc_26.col1.x * _loc_27.x + _loc_26.col2.x * _loc_27.y);
                                _loc_27.y = _loc_11.position.y + (_loc_26.col1.y * _loc_27.x + _loc_26.col2.y * _loc_27.y);
                                _loc_27.x = _loc_28;
                                _loc_2++;
                            }
                            m_debugDraw.DrawPolygon(_loc_14, 4, _loc_10);
                        }
                        _loc_4 = _loc_4.m_next;
                    }
                    _loc_3 = _loc_3.m_next;
                }
            }
            if (_loc_1 & b2DebugDraw.e_centerOfMassBit)
            {
                _loc_3 = m_bodyList;
                while (_loc_3)
                {
                    
                    _loc_11 = s_xf;
                    _loc_11.R = _loc_3.m_xf.R;
                    _loc_11.position = _loc_3.GetWorldCenter();
                    m_debugDraw.DrawXForm(_loc_11);
                    _loc_3 = _loc_3.m_next;
                }
            }
            return;
        }// end function

        public function DestroyBody(param1:b2Body) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (m_lock == true)
            {
                return;
            }
            _loc_2 = param1.m_jointList;
            while (_loc_2)
            {
                
                _loc_4 = _loc_2;
                _loc_2 = _loc_2.next;
                if (m_destructionListener)
                {
                    m_destructionListener.SayGoodbyeJoint(_loc_4.joint);
                }
                DestroyJoint(_loc_4.joint);
            }
            _loc_3 = param1.m_shapeList;
            while (_loc_3)
            {
                
                _loc_5 = _loc_3;
                _loc_3 = _loc_3.m_next;
                if (m_destructionListener)
                {
                    m_destructionListener.SayGoodbyeShape(_loc_5);
                }
                _loc_5.DestroyProxy(m_broadPhase);
                b2Shape.Destroy(_loc_5, m_blockAllocator);
            }
            if (param1.m_prev)
            {
                param1.m_prev.m_next = param1.m_next;
            }
            if (param1.m_next)
            {
                param1.m_next.m_prev = param1.m_prev;
            }
            if (param1 == m_bodyList)
            {
                m_bodyList = param1.m_next;
            }
            var _loc_7:* = m_bodyCount - 1;
            m_bodyCount = _loc_7;
            return;
        }// end function

        public function SetContactFilter(param1:b2ContactFilter) : void
        {
            m_contactFilter = param1;
            return;
        }// end function

        public function GetGroundBody() : b2Body
        {
            return m_groundBody;
        }// end function

        public function DrawShape(param1:b2Shape, param2:b2XForm, param3:b2Color, param4:Boolean) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = NaN;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            _loc_5 = s_coreColor;
            switch(param1.m_type)
            {
                case b2Shape.e_circleShape:
                {
                    _loc_6 = param1 as b2CircleShape;
                    _loc_7 = b2Math.b2MulX(param2, _loc_6.m_localPosition);
                    _loc_8 = _loc_6.m_radius;
                    _loc_9 = param2.R.col1;
                    m_debugDraw.DrawSolidCircle(_loc_7, _loc_8, _loc_9, param3);
                    if (param4)
                    {
                        m_debugDraw.DrawCircle(_loc_7, _loc_8 - b2Settings.b2_toiSlop, _loc_5);
                    }
                    break;
                }
                case b2Shape.e_polygonShape:
                {
                    _loc_11 = param1 as b2PolygonShape;
                    _loc_12 = _loc_11.GetVertexCount();
                    _loc_13 = _loc_11.GetVertices();
                    _loc_14 = new Array(b2Settings.b2_maxPolygonVertices);
                    _loc_10 = 0;
                    while (_loc_10 < _loc_12)
                    {
                        
                        _loc_14[_loc_10] = b2Math.b2MulX(param2, _loc_13[_loc_10]);
                        _loc_10++;
                    }
                    m_debugDraw.DrawSolidPolygon(_loc_14, _loc_12, param3);
                    if (param4)
                    {
                        _loc_15 = _loc_11.GetCoreVertices();
                        _loc_10 = 0;
                        while (_loc_10 < _loc_12)
                        {
                            
                            _loc_14[_loc_10] = b2Math.b2MulX(param2, _loc_15[_loc_10]);
                            _loc_10++;
                        }
                        m_debugDraw.DrawPolygon(_loc_14, _loc_12, _loc_5);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function GetContactCount() : int
        {
            return m_contactCount;
        }// end function

        public function Solve(param1:b2TimeStep) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = false;
            m_positionIterationCount = 0;
            _loc_3 = new b2Island(m_bodyCount, m_contactCount, m_jointCount, m_stackAllocator, m_contactListener);
            _loc_2 = m_bodyList;
            while (_loc_2)
            {
                
                _loc_2.m_flags = _loc_2.m_flags & ~b2Body.e_islandFlag;
                _loc_2 = _loc_2.m_next;
            }
            _loc_4 = m_contactList;
            while (_loc_4)
            {
                
                _loc_4.m_flags = _loc_4.m_flags & ~b2Contact.e_islandFlag;
                _loc_4 = _loc_4.m_next;
            }
            _loc_5 = m_jointList;
            while (_loc_5)
            {
                
                _loc_5.m_islandFlag = false;
                _loc_5 = _loc_5.m_next;
            }
            _loc_6 = m_bodyCount;
            _loc_7 = new Array(_loc_6);
            _loc_8 = m_bodyList;
            while (_loc_8)
            {
                
                if (_loc_8.m_flags & (b2Body.e_islandFlag | b2Body.e_sleepFlag | b2Body.e_frozenFlag))
                {
                }
                else if (_loc_8.IsStatic())
                {
                }
                else
                {
                    _loc_3.Clear();
                    _loc_9 = 0;
                    _loc_7[++_loc_9] = _loc_8;
                    _loc_8.m_flags = _loc_8.m_flags | b2Body.e_islandFlag;
                    while (_loc_9 > 0)
                    {
                        
                        _loc_2 = _loc_7[--_loc_9];
                        _loc_3.AddBody(_loc_2);
                        _loc_2.m_flags = _loc_2.m_flags & ~b2Body.e_sleepFlag;
                        if (_loc_2.IsStatic())
                        {
                            continue;
                        }
                        _loc_12 = _loc_2.m_contactList;
                        while (_loc_12)
                        {
                            
                            if (_loc_12.contact.m_flags & (b2Contact.e_islandFlag | b2Contact.e_nonSolidFlag))
                            {
                            }
                            else if (_loc_12.contact.m_manifoldCount == 0)
                            {
                            }
                            else
                            {
                                _loc_3.AddContact(_loc_12.contact);
                                _loc_12.contact.m_flags = _loc_12.contact.m_flags | b2Contact.e_islandFlag;
                                _loc_11 = _loc_12.other;
                                if (_loc_11.m_flags & b2Body.e_islandFlag)
                                {
                                }
                                else
                                {
                                    _loc_9 = --_loc_9 + 1;
                                    _loc_7[--_loc_9] = _loc_11;
                                    _loc_11.m_flags = _loc_11.m_flags | b2Body.e_islandFlag;
                                }
                            }
                            _loc_12 = _loc_12.next;
                        }
                        _loc_13 = _loc_2.m_jointList;
                        while (_loc_13)
                        {
                            
                            if (_loc_13.joint.m_islandFlag == true)
                            {
                            }
                            else
                            {
                                _loc_3.AddJoint(_loc_13.joint);
                                _loc_13.joint.m_islandFlag = true;
                                _loc_11 = _loc_13.other;
                                if (_loc_11.m_flags & b2Body.e_islandFlag)
                                {
                                }
                                else
                                {
                                    _loc_7[++_loc_9] = _loc_11;
                                    _loc_11.m_flags = _loc_11.m_flags | b2Body.e_islandFlag;
                                }
                            }
                            _loc_13 = _loc_13.next;
                        }
                    }
                    _loc_3.Solve(param1, m_gravity, m_positionCorrection, m_allowSleep);
                    if (_loc_3.m_positionIterationCount > m_positionIterationCount)
                    {
                        m_positionIterationCount = _loc_3.m_positionIterationCount;
                    }
                    _loc_10 = 0;
                    while (_loc_10 < _loc_3.m_bodyCount)
                    {
                        
                        _loc_2 = _loc_3.m_bodies[_loc_10];
                        if (_loc_2.IsStatic())
                        {
                            _loc_2.m_flags = _loc_2.m_flags & ~b2Body.e_islandFlag;
                        }
                        _loc_10++;
                    }
                }
                _loc_8 = _loc_8.m_next;
            }
            _loc_2 = m_bodyList;
            while (_loc_2)
            {
                
                if (_loc_2.m_flags & (b2Body.e_sleepFlag | b2Body.e_frozenFlag))
                {
                }
                else if (_loc_2.IsStatic())
                {
                }
                else
                {
                    _loc_14 = _loc_2.SynchronizeShapes();
                    if (_loc_14 == false && m_boundaryListener != null)
                    {
                        m_boundaryListener.Violation(_loc_2);
                    }
                }
                _loc_2 = _loc_2.m_next;
            }
            m_broadPhase.Commit();
            return;
        }// end function

        public function Query(param1:b2AABB, param2:Array, param3:int) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            _loc_4 = new Array(param3);
            _loc_5 = m_broadPhase.QueryAABB(param1, _loc_4, param3);
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                param2[_loc_6] = _loc_4[_loc_6];
                _loc_6++;
            }
            return _loc_5;
        }// end function

        public function SetGravity(param1:b2Vec2) : void
        {
            m_gravity = param1;
            return;
        }// end function

        public function SolveTOI(param1:b2TimeStep) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = null;
            var _loc_21:* = false;
            _loc_8 = new b2Island(m_bodyCount, b2Settings.b2_maxTOIContactsPerIsland, 0, m_stackAllocator, m_contactListener);
            _loc_9 = m_bodyCount;
            _loc_10 = new Array(_loc_9);
            _loc_2 = m_bodyList;
            while (_loc_2)
            {
                
                _loc_2.m_flags = _loc_2.m_flags & ~b2Body.e_islandFlag;
                _loc_2.m_sweep.t0 = 0;
                _loc_2 = _loc_2.m_next;
            }
            _loc_11 = m_contactList;
            while (_loc_11)
            {
                
                _loc_11.m_flags = _loc_11.m_flags & ~(b2Contact.e_toiFlag | b2Contact.e_islandFlag);
                _loc_11 = _loc_11.m_next;
            }
            while (true)
            {
                
                _loc_12 = null;
                _loc_13 = 1;
                _loc_11 = m_contactList;
                while (_loc_11)
                {
                    
                    if (_loc_11.m_flags & (b2Contact.e_slowFlag | b2Contact.e_nonSolidFlag))
                    {
                    }
                    else
                    {
                        _loc_18 = 1;
                        if (_loc_11.m_flags & b2Contact.e_toiFlag)
                        {
                            _loc_18 = _loc_11.m_toi;
                        }
                        else
                        {
                            _loc_3 = _loc_11.m_shape1;
                            _loc_4 = _loc_11.m_shape2;
                            _loc_5 = _loc_3.m_body;
                            _loc_6 = _loc_4.m_body;
                            if ((_loc_5.IsStatic() || _loc_5.IsSleeping()) && (_loc_6.IsStatic() || _loc_6.IsSleeping()))
                            {
                            }
                            _loc_19 = _loc_5.m_sweep.t0;
                            if (_loc_5.m_sweep.t0 < _loc_6.m_sweep.t0)
                            {
                                _loc_19 = _loc_6.m_sweep.t0;
                                _loc_5.m_sweep.Advance(_loc_19);
                            }
                            else if (_loc_6.m_sweep.t0 < _loc_5.m_sweep.t0)
                            {
                                _loc_19 = _loc_5.m_sweep.t0;
                                _loc_6.m_sweep.Advance(_loc_19);
                            }
                            _loc_18 = b2TimeOfImpact.TimeOfImpact(_loc_11.m_shape1, _loc_5.m_sweep, _loc_11.m_shape2, _loc_6.m_sweep);
                            if (_loc_18 > 0 && _loc_18 < 1)
                            {
                                _loc_18 = (1 - _loc_18) * _loc_19 + _loc_18;
                                if (_loc_18 > 1)
                                {
                                    _loc_18 = 1;
                                }
                            }
                            _loc_11.m_toi = _loc_18;
                            _loc_11.m_flags = _loc_11.m_flags | b2Contact.e_toiFlag;
                        }
                        if (Number.MIN_VALUE < _loc_18 && _loc_18 < _loc_13)
                        {
                            _loc_12 = _loc_11;
                            _loc_13 = _loc_18;
                        }
                    }
                    _loc_11 = _loc_11.m_next;
                }
                if (_loc_12 == null || 1 - 100 * Number.MIN_VALUE < _loc_13)
                {
                    break;
                }
                _loc_3 = _loc_12.m_shape1;
                _loc_4 = _loc_12.m_shape2;
                _loc_5 = _loc_3.m_body;
                _loc_6 = _loc_4.m_body;
                _loc_5.Advance(_loc_13);
                _loc_6.Advance(_loc_13);
                _loc_12.Update(m_contactListener);
                _loc_12.m_flags = _loc_12.m_flags & ~b2Contact.e_toiFlag;
                if (_loc_12.m_manifoldCount == 0)
                {
                    continue;
                }
                _loc_14 = _loc_5;
                if (_loc_14.IsStatic())
                {
                    _loc_14 = _loc_6;
                }
                _loc_8.Clear();
                _loc_15 = 0;
                _loc_10[++_loc_15] = _loc_14;
                _loc_14.m_flags = _loc_14.m_flags | b2Body.e_islandFlag;
                while (_loc_15 > 0)
                {
                    
                    _loc_2 = _loc_10[--_loc_15];
                    _loc_8.AddBody(_loc_2);
                    _loc_2.m_flags = _loc_2.m_flags & ~b2Body.e_sleepFlag;
                    if (_loc_2.IsStatic())
                    {
                        continue;
                    }
                    _loc_7 = _loc_2.m_contactList;
                    while (_loc_7)
                    {
                        
                        if (_loc_8.m_contactCount == _loc_8.m_contactCapacity)
                        {
                        }
                        else if (_loc_7.contact.m_flags & (b2Contact.e_islandFlag | b2Contact.e_slowFlag | b2Contact.e_nonSolidFlag))
                        {
                        }
                        else if (_loc_7.contact.m_manifoldCount == 0)
                        {
                        }
                        else
                        {
                            _loc_8.AddContact(_loc_7.contact);
                            _loc_7.contact.m_flags = _loc_7.contact.m_flags | b2Contact.e_islandFlag;
                            _loc_20 = _loc_7.other;
                            if (_loc_20.m_flags & b2Body.e_islandFlag)
                            {
                            }
                            else
                            {
                                if (_loc_20.IsStatic() == false)
                                {
                                    _loc_20.Advance(_loc_13);
                                    _loc_20.WakeUp();
                                }
                                _loc_15 = --_loc_15 + 1;
                                _loc_10[--_loc_15] = _loc_20;
                                _loc_20.m_flags = _loc_20.m_flags | b2Body.e_islandFlag;
                            }
                        }
                        _loc_7 = _loc_7.next;
                    }
                }
                _loc_16 = new b2TimeStep();
                _loc_16.dt = (1 - _loc_13) * param1.dt;
                _loc_16.inv_dt = 1 / _loc_16.dt;
                _loc_16.maxIterations = param1.maxIterations;
                _loc_8.SolveTOI(_loc_16);
                _loc_17 = 0;
                while (_loc_17 < _loc_8.m_bodyCount)
                {
                    
                    _loc_2 = _loc_8.m_bodies[_loc_17];
                    _loc_2.m_flags = _loc_2.m_flags & ~b2Body.e_islandFlag;
                    if (_loc_2.m_flags & (b2Body.e_sleepFlag | b2Body.e_frozenFlag))
                    {
                    }
                    else if (_loc_2.IsStatic())
                    {
                    }
                    else
                    {
                        _loc_21 = _loc_2.SynchronizeShapes();
                        if (_loc_21 == false && m_boundaryListener != null)
                        {
                            m_boundaryListener.Violation(_loc_2);
                        }
                        _loc_7 = _loc_2.m_contactList;
                        while (_loc_7)
                        {
                            
                            _loc_7.contact.m_flags = _loc_7.contact.m_flags & ~b2Contact.e_toiFlag;
                            _loc_7 = _loc_7.next;
                        }
                    }
                    _loc_17++;
                }
                _loc_17 = 0;
                while (_loc_17 < _loc_8.m_contactCount)
                {
                    
                    _loc_11 = _loc_8.m_contacts[_loc_17];
                    _loc_11.m_flags = _loc_11.m_flags & ~(b2Contact.e_toiFlag | b2Contact.e_islandFlag);
                    _loc_17++;
                }
                m_broadPhase.Commit();
            }
            return;
        }// end function

        public function GetJointList() : b2Joint
        {
            return m_jointList;
        }// end function

        public function Validate() : void
        {
            m_broadPhase.Validate();
            return;
        }// end function

        public function GetPairCount() : int
        {
            return m_broadPhase.m_pairManager.m_pairCount;
        }// end function

        public function GetBodyList() : b2Body
        {
            return m_bodyList;
        }// end function

        public function SetWarmStarting(param1:Boolean) : void
        {
            m_warmStarting = param1;
            return;
        }// end function

        public function SetPositionCorrection(param1:Boolean) : void
        {
            m_positionCorrection = param1;
            return;
        }// end function

        public function CreateJoint(param1:b2JointDef) : b2Joint
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            _loc_2 = b2Joint.Create(param1, m_blockAllocator);
            _loc_2.m_prev = null;
            _loc_2.m_next = m_jointList;
            if (m_jointList)
            {
                m_jointList.m_prev = _loc_2;
            }
            m_jointList = _loc_2;
            var _loc_6:* = m_jointCount + 1;
            m_jointCount = _loc_6;
            _loc_2.m_node1.joint = _loc_2;
            _loc_2.m_node1.other = _loc_2.m_body2;
            _loc_2.m_node1.prev = null;
            _loc_2.m_node1.next = _loc_2.m_body1.m_jointList;
            if (_loc_2.m_body1.m_jointList)
            {
                _loc_2.m_body1.m_jointList.prev = _loc_2.m_node1;
            }
            _loc_2.m_body1.m_jointList = _loc_2.m_node1;
            _loc_2.m_node2.joint = _loc_2;
            _loc_2.m_node2.other = _loc_2.m_body1;
            _loc_2.m_node2.prev = null;
            _loc_2.m_node2.next = _loc_2.m_body2.m_jointList;
            if (_loc_2.m_body2.m_jointList)
            {
                _loc_2.m_body2.m_jointList.prev = _loc_2.m_node2;
            }
            _loc_2.m_body2.m_jointList = _loc_2.m_node2;
            if (param1.collideConnected == false)
            {
                _loc_3 = param1.body1.m_shapeCount < param1.body2.m_shapeCount ? (param1.body1) : (param1.body2);
                _loc_4 = _loc_3.m_shapeList;
                while (_loc_4)
                {
                    
                    _loc_4.RefilterProxy(m_broadPhase, _loc_3.m_xf);
                    _loc_4 = _loc_4.m_next;
                }
            }
            return _loc_2;
        }// end function

        public function DestroyJoint(param1:b2Joint) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            _loc_2 = param1.m_collideConnected;
            if (param1.m_prev)
            {
                param1.m_prev.m_next = param1.m_next;
            }
            if (param1.m_next)
            {
                param1.m_next.m_prev = param1.m_prev;
            }
            if (param1 == m_jointList)
            {
                m_jointList = param1.m_next;
            }
            _loc_3 = param1.m_body1;
            _loc_4 = param1.m_body2;
            _loc_3.WakeUp();
            _loc_4.WakeUp();
            if (param1.m_node1.prev)
            {
                param1.m_node1.prev.next = param1.m_node1.next;
            }
            if (param1.m_node1.next)
            {
                param1.m_node1.next.prev = param1.m_node1.prev;
            }
            if (param1.m_node1 == _loc_3.m_jointList)
            {
                _loc_3.m_jointList = param1.m_node1.next;
            }
            param1.m_node1.prev = null;
            param1.m_node1.next = null;
            if (param1.m_node2.prev)
            {
                param1.m_node2.prev.next = param1.m_node2.next;
            }
            if (param1.m_node2.next)
            {
                param1.m_node2.next.prev = param1.m_node2.prev;
            }
            if (param1.m_node2 == _loc_4.m_jointList)
            {
                _loc_4.m_jointList = param1.m_node2.next;
            }
            param1.m_node2.prev = null;
            param1.m_node2.next = null;
            b2Joint.Destroy(param1, m_blockAllocator);
            var _loc_8:* = m_jointCount - 1;
            m_jointCount = _loc_8;
            if (_loc_2 == false)
            {
                _loc_5 = _loc_3.m_shapeCount < _loc_4.m_shapeCount ? (_loc_3) : (_loc_4);
                _loc_6 = _loc_5.m_shapeList;
                while (_loc_6)
                {
                    
                    _loc_6.RefilterProxy(m_broadPhase, _loc_5.m_xf);
                    _loc_6 = _loc_6.m_next;
                }
            }
            return;
        }// end function

        public function SetContactListener(param1:b2ContactListener) : void
        {
            m_contactListener = param1;
            return;
        }// end function

        public function CreateBody(param1:b2BodyDef) : b2Body
        {
            var _loc_2:* = null;
            if (m_lock == true)
            {
                return null;
            }
            _loc_2 = new b2Body(param1, this);
            _loc_2.m_prev = null;
            _loc_2.m_next = m_bodyList;
            if (m_bodyList)
            {
                m_bodyList.m_prev = _loc_2;
            }
            m_bodyList = _loc_2;
            var _loc_4:* = m_bodyCount + 1;
            m_bodyCount = _loc_4;
            return _loc_2;
        }// end function

        public function SetBoundaryListener(param1:b2BoundaryListener) : void
        {
            m_boundaryListener = param1;
            return;
        }// end function

        public function SetDestructionListener(param1:b2DestructionListener) : void
        {
            m_destructionListener = param1;
            return;
        }// end function

        public function Step(param1:Number, param2:int) : void
        {
            var _loc_3:* = null;
            m_lock = true;
            _loc_3 = new b2TimeStep();
            _loc_3.dt = param1;
            _loc_3.maxIterations = param2;
            if (param1 > 0)
            {
                _loc_3.inv_dt = 1 / param1;
            }
            else
            {
                _loc_3.inv_dt = 0;
            }
            _loc_3.dtRatio = m_inv_dt0 * param1;
            _loc_3.positionCorrection = m_positionCorrection;
            _loc_3.warmStarting = m_warmStarting;
            m_contactManager.Collide();
            if (_loc_3.dt > 0)
            {
                Solve(_loc_3);
            }
            if (m_continuousPhysics && _loc_3.dt > 0)
            {
                SolveTOI(_loc_3);
            }
            DrawDebugData();
            m_inv_dt0 = _loc_3.inv_dt;
            m_lock = false;
            return;
        }// end function

        public function GetBodyCount() : int
        {
            return m_bodyCount;
        }// end function

        public function GetJointCount() : int
        {
            return m_jointCount;
        }// end function

    }
}
