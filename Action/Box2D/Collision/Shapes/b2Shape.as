package Box2D.Collision.Shapes
{
    import Box2D.Collision.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;

    public class b2Shape extends Object
    {
        public var m_type:int;
        public var m_sweepRadius:Number;
        public var m_density:Number;
        public var m_filter:b2FilterData;
        public var m_friction:Number;
        public var m_next:b2Shape;
        public var m_restitution:Number;
        public var m_userData:Object;
        public var m_isSensor:Boolean;
        public var m_proxyId:uint;
        public var m_body:b2Body;
        public static const e_polygonShape:int = 1;
        private static var s_resetAABB:b2AABB = new b2AABB();
        private static var s_syncAABB:b2AABB = new b2AABB();
        private static var s_proxyAABB:b2AABB = new b2AABB();
        public static const e_unknownShape:int = -1;
        public static const e_circleShape:int = 0;
        public static const e_shapeTypeCount:int = 2;

        public function b2Shape(param1:b2ShapeDef)
        {
            m_userData = param1.userData;
            m_friction = param1.friction;
            m_restitution = param1.restitution;
            m_density = param1.density;
            m_body = null;
            m_sweepRadius = 0;
            m_next = null;
            m_proxyId = b2Pair.b2_nullProxy;
            m_filter = param1.filter.Copy();
            m_isSensor = param1.isSensor;
            return;
        }// end function

        public function TestPoint(param1:b2XForm, param2:b2Vec2) : Boolean
        {
            return false;
        }// end function

        public function GetSweepRadius() : Number
        {
            return m_sweepRadius;
        }// end function

        public function GetNext() : b2Shape
        {
            return m_next;
        }// end function

        public function ComputeSweptAABB(param1:b2AABB, param2:b2XForm, param3:b2XForm) : void
        {
            return;
        }// end function

        public function GetType() : int
        {
            return m_type;
        }// end function

        public function GetRestitution() : Number
        {
            return m_restitution;
        }// end function

        public function GetFriction() : Number
        {
            return m_friction;
        }// end function

        public function GetFilterData() : b2FilterData
        {
            return m_filter.Copy();
        }// end function

        public function TestSegment(param1:b2XForm, param2:Array, param3:b2Vec2, param4:b2Segment, param5:Number) : Boolean
        {
            return false;
        }// end function

        public function RefilterProxy(param1:b2BroadPhase, param2:b2XForm) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = false;
            if (m_proxyId == b2Pair.b2_nullProxy)
            {
                return;
            }
            param1.DestroyProxy(m_proxyId);
            _loc_3 = s_resetAABB;
            ComputeAABB(_loc_3, param2);
            _loc_4 = param1.InRange(_loc_3);
            if (_loc_4)
            {
                m_proxyId = param1.CreateProxy(_loc_3, this);
            }
            else
            {
                m_proxyId = b2Pair.b2_nullProxy;
            }
            return;
        }// end function

        public function SetFilterData(param1:b2FilterData) : void
        {
            m_filter = param1.Copy();
            return;
        }// end function

        public function GetUserData()
        {
            return m_userData;
        }// end function

        public function Synchronize(param1:b2BroadPhase, param2:b2XForm, param3:b2XForm) : Boolean
        {
            var _loc_4:* = null;
            if (m_proxyId == b2Pair.b2_nullProxy)
            {
                return false;
            }
            _loc_4 = s_syncAABB;
            ComputeSweptAABB(_loc_4, param2, param3);
            if (param1.InRange(_loc_4))
            {
                param1.MoveProxy(m_proxyId, _loc_4);
                return true;
            }
            return false;
        }// end function

        public function ComputeMass(param1:b2MassData) : void
        {
            return;
        }// end function

        public function IsSensor() : Boolean
        {
            return m_isSensor;
        }// end function

        public function DestroyProxy(param1:b2BroadPhase) : void
        {
            if (m_proxyId != b2Pair.b2_nullProxy)
            {
                param1.DestroyProxy(m_proxyId);
                m_proxyId = b2Pair.b2_nullProxy;
            }
            return;
        }// end function

        public function UpdateSweepRadius(param1:b2Vec2) : void
        {
            return;
        }// end function

        public function ComputeAABB(param1:b2AABB, param2:b2XForm) : void
        {
            return;
        }// end function

        public function GetBody() : b2Body
        {
            return m_body;
        }// end function

        public function CreateProxy(param1:b2BroadPhase, param2:b2XForm) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = false;
            _loc_3 = s_proxyAABB;
            ComputeAABB(_loc_3, param2);
            _loc_4 = param1.InRange(_loc_3);
            if (_loc_4)
            {
                m_proxyId = param1.CreateProxy(_loc_3, this);
            }
            else
            {
                m_proxyId = b2Pair.b2_nullProxy;
            }
            return;
        }// end function

        public function SetUserData(param1) : void
        {
            m_userData = param1;
            return;
        }// end function

        public static function Destroy(param1:b2Shape, param2) : void
        {
            return;
        }// end function

        public static function Create(param1:b2ShapeDef, param2) : b2Shape
        {
            switch(param1.type)
            {
                case e_circleShape:
                {
                    return new b2CircleShape(param1);
                }
                case e_polygonShape:
                {
                    return new b2PolygonShape(param1);
                }
                default:
                {
                    return null;
                    break;
                }
            }
        }// end function

    }
}
