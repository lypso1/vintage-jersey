import PropTypes from "prop-types";
import { Card, Col, Badge, Stack } from "react-bootstrap";
import { truncateAddress } from "../../../utils";
import Identicon from "../../ui/Identicon";
import { ERC20_DECIMALS } from "../../../utils/constants";

// NFT Cards Functionality
const Nft = ({ nft, buyNft, address }) => {
  const { image, description, owner, name, tokenId, price, isSold } = nft;

  const buttonFunc = (isSold, buyNft, owner, address) => {
    let btnText;
    if(owner !== address) {
      isSold ? btnText = <button className="sold_nft">Sold</button> : btnText = <button className="buy_nft" onClick={buyNft}>Buy</button>
    }
    else {
      btnText = <button className="owned_nft">Owned</button>
    }
    return <>{btnText}</>
  }

  return (
    <Col key={tokenId}>
      <Card className="h-100 jersey_card">
        <Card.Header>
          <Stack direction="horizontal" gap={2}>
            <Identicon address={owner} size={50} />
            <span className="text-secondary">
              {truncateAddress(owner)}
            </span>
            <Badge className="card_price ms-auto px-3 py-2">
              {price / (10 ** ERC20_DECIMALS)} CELO
            </Badge>
          </Stack>
        </Card.Header>

        <div className=" ratio ratio-4x3">
          <img src={image} alt={description} style={{ objectFit: "cover" }} />
        </div>

        <Card.Body className="d-flex  flex-column text-center">
          <Card.Title className="card_title">{name}</Card.Title>
          <Card.Text className="flex-grow-1">{description}</Card.Text>
          <div>
          
          </div>
          {buttonFunc(isSold, buyNft, owner, address)}
        </Card.Body>
      </Card>
    </Col>
  );
};

Nft.propTypes = {
  // props passed into this component
  nft: PropTypes.instanceOf(Object).isRequired,
};

export default Nft;
