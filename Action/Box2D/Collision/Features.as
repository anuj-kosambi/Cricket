package Box2D.Collision
{

    public class Features extends Object
    {
        public var _referenceEdge:int;
        public var _incidentEdge:int;
        public var _flip:int;
        public var _incidentVertex:int;
        public var _m_id:b2ContactID;

        public function Features()
        {
            return;
        }// end function

        public function get referenceEdge() : int
        {
            return _referenceEdge;
        }// end function

        public function set incidentVertex(param1:int) : void
        {
            _incidentVertex = param1;
            _m_id._key = _m_id._key & 4278255615 | _incidentVertex << 16 & 16711680;
            return;
        }// end function

        public function get flip() : int
        {
            return _flip;
        }// end function

        public function get incidentEdge() : int
        {
            return _incidentEdge;
        }// end function

        public function set referenceEdge(param1:int) : void
        {
            _referenceEdge = param1;
            _m_id._key = _m_id._key & 4294967040 | _referenceEdge & 255;
            return;
        }// end function

        public function set flip(param1:int) : void
        {
            _flip = param1;
            _m_id._key = _m_id._key & 16777215 | _flip << 24 & 4278190080;
            return;
        }// end function

        public function get incidentVertex() : int
        {
            return _incidentVertex;
        }// end function

        public function set incidentEdge(param1:int) : void
        {
            _incidentEdge = param1;
            _m_id._key = _m_id._key & 4294902015 | _incidentEdge << 8 & 65280;
            return;
        }// end function

    }
}
