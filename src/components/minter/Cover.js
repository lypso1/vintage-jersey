import React from 'react';

const Cover = ({ connect }) => {
    return (
      <div className="jersey_cover">
        <div className="mt-auto text-light mb-0">
          <div className="cover_img">
            <img src="https://i0.wp.com/russianmachineneverbreaks.com/wp-content/uploads/2018/05/adidas-nhl-jerseys.jpg?fit=960%2C480&ssl=1" alt=""/>
          </div>
          <h1>Vintage Jersey NFT Collection</h1>
          <p>We offer a platfirm to buy and sell your vintage jersey NFT's </p>
          <button
            onClick={() => connect().catch((e) => console.log(e))}
          >
            Connect Wallet
          </button>
        </div>

      </div>
    );
};

export default Cover;
