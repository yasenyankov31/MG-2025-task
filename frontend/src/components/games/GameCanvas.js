import React, { useRef, useEffect, useState } from 'react';
import { Button, Container } from 'react-bootstrap';
import TranslateI18n from '../general/TranslateI18n';


const GameCanvas = ({ wordToGuess, attempts, resetGame }) => {
    const canvasRef = useRef(null);
    const ctxRef = useRef(null);
    const [fadeButton, setFadeButton] = useState("");
    const [isButtonDisabled, setIsButtonDisabled] = useState(false);



    const drawLineAnimated = (ctx, startX, startY, endX, endY, duration, callback) => {
        const startTime = performance.now();

        const drawLineSegment = (currentTime) => {
            const elapsed = currentTime - startTime;
            const t = Math.min(elapsed / duration, 1);

            const currentX = startX + (endX - startX) * t;
            const currentY = startY + (endY - startY) * t;

            ctx.beginPath();
            ctx.moveTo(startX, startY);
            ctx.lineTo(currentX, currentY);
            ctx.stroke();

            if (t < 1) {
                requestAnimationFrame(drawLineSegment);
            } else {
                if (callback) callback();
            }
        };

        requestAnimationFrame(drawLineSegment);
    };

    const drawCircleAnimated = (ctx, x, y, radius, duration, callback) => {
        const startTime = performance.now();

        const drawArcSegment = (currentTime) => {
            const elapsed = currentTime - startTime;
            const t = Math.min(elapsed / duration, 1);

            const endAngle = Math.PI * 2 * t;
            if (endAngle > 0) {
                ctx.beginPath();
                ctx.arc(x, y, radius, 0, endAngle);
                ctx.stroke();
            }


            if (t < 1) {
                requestAnimationFrame(drawArcSegment);
            } else {
                if (callback) callback();
            }
        };

        requestAnimationFrame(drawArcSegment);
    };

    const clearCanvas = () => {
        ctxRef.current.beginPath();
        ctxRef.current.clearRect(0, 0, 500, 500);
    };

    const drawFigure = (attempts) => {
        const ctx = ctxRef.current;
        const miliseconds = 500;

        switch (attempts) {
            case 8:
                clearCanvas();
                break;
            case 7:
                drawLineAnimated(ctx, 100, 400, 200, 400, miliseconds);
                break;
            case 6:
                // Draw gallows
                drawLineAnimated(ctx, 150, 400, 150, 100, miliseconds);
                break;
            case 5:
                // Draw gallows
                drawLineAnimated(ctx, 150, 100, 250, 100, miliseconds);
                break;
            case 4:
                drawLineAnimated(ctx, 250, 100, 250, 150, miliseconds);
                break;
            case 3:
                // Draw head
                drawCircleAnimated(ctx, 250, 175, 25, miliseconds);
                break;
            case 2:
                // Draw body
                drawLineAnimated(ctx, 250, 200, 250, 300, miliseconds);
                break;
            case 1:
                //left arm
                drawLineAnimated(ctx, 250, 220, 250, 200, miliseconds);
                drawLineAnimated(ctx, 250, 220, 200, 260, miliseconds);

                //right arm
                drawLineAnimated(ctx, 250, 260, 250, 220, miliseconds);
                drawLineAnimated(ctx, 250, 220, 300, 260, miliseconds);

                break;
            case 0:
                //right leg
                drawLineAnimated(ctx, 250, 300, 300, 350, 1000);
                //left leg
                drawLineAnimated(ctx, 250, 300, 200, 350, 1000);
                break;

            default:
                break;
        }
        setIsButtonDisabled(true);
        setTimeout(() => setIsButtonDisabled(false), 1000);
    }
    useEffect(() => {
        const canvas = canvasRef.current;
        ctxRef.current = canvas.getContext('2d');

    }, []);

    useEffect(() => {
        if (attempts === 0) {
            setFadeButton("reset-button");
            setIsButtonDisabled(true);
        }
        for (let index = 7; index >= attempts; index--) {
            drawFigure(index)
        }
    }, [attempts]);

    const characters = wordToGuess.split('');


    return (
        <Container className="d-flex align-items-center justify-content-center">
            <div className='guessed-word-container'>
                {characters.includes('*') && attempts !== 0 && 
                <Button onClick={() => {
                    resetGame();
                    clearCanvas();
                }}
                    id={fadeButton} className='reset-button' disabled={isButtonDisabled} ><TranslateI18n id={"GameResetBtn"}/>
                </Button>}

                <canvas ref={canvasRef} width="500" height="500" className='game-canvas' />

                <div className='result'>
                    {characters.map((char, index) =>
                        <p
                            key={index}
                            className="inline underline-breaks"
                        >
                            {char + ' '}
                        </p>
                    )}</div>

            </div>
        </Container>
    );
};

export default GameCanvas;
