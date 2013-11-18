package Box2D.Dynamics.Contacts
{
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;

    public class b2Contact extends Object
    {
        public var m_shape1:b2Shape;
        public var m_shape2:b2Shape;
        public var m_prev:b2Contact;
        public var m_toi:Number;
        public var m_next:b2Contact;
        public var m_friction:Number;
        public var m_manifoldCount:int;
        public var m_node1:b2ContactEdge;
        public var m_node2:b2ContactEdge;
        public var m_restitution:Number;
        public var m_flags:uint;
        public static var e_toiFlag:uint = 8;
        public static var e_nonSolidFlag:uint = 1;
        public static var e_slowFlag:uint = 2;
        public static var e_islandFlag:uint = 4;
        public static var s_registers:Array;
        public static var s_initialized:Boolean = false;

        public function b2Contact(param1:b2Shape = null, param2:b2Shape = null)
        {
            m_node1 = new b2ContactEdge();
            m_node2 = new b2ContactEdge();
            m_flags = 0;
            if (!param1 || !param2)
            {
                m_shape1 = null;
                m_shape2 = null;
                return;
            }
            if (param1.IsSensor() || param2.IsSensor())
            {
                m_flags = m_flags | e_nonSolidFlag;
            }
            m_shape1 = param1;
            m_shape2 = param2;
            m_manifoldCount = 0;
            m_friction = Math.sqrt(m_shape1.m_friction * m_shape2.m_friction);
            m_restitution = b2Math.b2Max(m_shape1.m_restitution, m_shape2.m_restitution);
            m_prev = null;
            m_next = null;
            m_node1.contact = null;
            m_node1.prev = null;
            m_node1.next = null;
            m_node1.other = null;
            m_node2.contact = null;
            m_node2.prev = null;
            m_node2.next = null;
            m_node2.other = null;
            return;
        }// end function

        public function GetShape1() : b2Shape
        {
            return m_shape1;
        }// end function

        public function IsSolid() : Boolean
        {
            return (m_flags & e_nonSolidFlag) == 0;
        }// end function

        public function GetNext() : b2Contact
        {
            return m_next;
        }// end function

        public function GetManifolds() : Array
        {
            return null;
        }// end function

        public function GetShape2() : b2Shape
        {
            return m_shape2;
        }// end function

        public function GetManifoldCount() : int
        {
            return m_manifoldCount;
        }// end function

        public function Update(param1:b2ContactListener) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_2 = m_manifoldCount;
            Evaluate(param1);
            _loc_3 = m_manifoldCount;
            _loc_4 = m_shape1.m_body;
            _loc_5 = m_shape2.m_body;
            if (_loc_3 == 0 && _loc_2 > 0)
            {
                _loc_4.WakeUp();
                _loc_5.WakeUp();
            }
            if (_loc_4.IsStatic() || _loc_4.IsBullet() || _loc_5.IsStatic() || _loc_5.IsBullet())
            {
                m_flags = m_flags & ~e_slowFlag;
            }
            else
            {
                m_flags = m_flags | e_slowFlag;
            }
            return;
        }// end function

        public function Evaluate(param1:b2ContactListener) : void
        {
            return;
        }// end function

        public static function InitializeRegisters() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            s_registers = new Array(b2Shape.e_shapeTypeCount);
            _loc_1 = 0;
            while (_loc_1 < b2Shape.e_shapeTypeCount)
            {
                
                s_registers[_loc_1] = new Array(b2Shape.e_shapeTypeCount);
                _loc_2 = 0;
                while (_loc_2 < b2Shape.e_shapeTypeCount)
                {
                    
                    s_registers[_loc_1][_loc_2] = new b2ContactRegister();
                    _loc_2++;
                }
                _loc_1++;
            }
            AddType(b2CircleContact.Create, b2CircleContact.Destroy, b2Shape.e_circleShape, b2Shape.e_circleShape);
            AddType(b2PolyAndCircleContact.Create, b2PolyAndCircleContact.Destroy, b2Shape.e_polygonShape, b2Shape.e_circleShape);
            AddType(b2PolygonContact.Create, b2PolygonContact.Destroy, b2Shape.e_polygonShape, b2Shape.e_polygonShape);
            return;
        }// end function

        public static function Destroy(param1:b2Contact, param2) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param1.m_manifoldCount > 0)
            {
                param1.m_shape1.m_body.WakeUp();
                param1.m_shape2.m_body.WakeUp();
            }
            _loc_3 = param1.m_shape1.m_type;
            _loc_4 = param1.m_shape2.m_type;
            _loc_5 = s_registers[_loc_3][_loc_4];
            _loc_6 = _loc_5.destroyFcn;
            b2Contact._loc_6(param1, param2);
            return;
        }// end function

        public static function AddType(param1:Function, param2:Function, param3:int, param4:int) : void
        {
            s_registers[param3][param4].createFcn = param1;
            s_registers[param3][param4].destroyFcn = param2;
            s_registers[param3][param4].primary = true;
            if (param3 != param4)
            {
                s_registers[param4][param3].createFcn = param1;
                s_registers[param4][param3].destroyFcn = param2;
                s_registers[param4][param3].primary = false;
            }
            return;
        }// end function

        public static function Create(param1:b2Shape, param2:b2Shape, param3) : b2Contact
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            if (s_initialized == false)
            {
                InitializeRegisters();
                s_initialized = true;
            }
            _loc_4 = param1.m_type;
            _loc_5 = param2.m_type;
            _loc_6 = s_registers[_loc_4][_loc_5];
            _loc_7 = _loc_6.createFcn;
            if (_loc_7 != null)
            {
                if (_loc_6.primary)
                {
                    return b2Contact._loc_7(param1, param2, param3);
                }
                _loc_8 = b2Contact._loc_7(param2, param1, param3);
                _loc_9 = 0;
                while (_loc_9 < _loc_8.m_manifoldCount)
                {
                    
                    _loc_10 = _loc_8.GetManifolds()[_loc_9];
                    _loc_10.normal = _loc_10.normal.Negative();
                    _loc_9++;
                }
                return _loc_8;
            }
            else
            {
                return null;
            }
        }// end function

    }
}
