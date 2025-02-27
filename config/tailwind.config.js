module.exports = {
  theme: {
    extend: {
      animation: {
        'fade-in-down': 'fadeInDown 0.3s ease-out',
        'fade-out-up': 'fadeOutUp 0.3s ease-out',
      },
      keyframes: {
        fadeInDown: {
          '0%': {
            opacity: '0',
            transform: 'translate(-50%, -2rem)',
          },
          '100%': {
            opacity: '1',
            transform: 'translate(-50%, 0)',
          },
        },
        fadeOutUp: {
          '0%': {
            opacity: '1',
            transform: 'translate(-50%, 0)',
          },
          '100%': {
            opacity: '0',
            transform: 'translate(-50%, -2rem)',
          },
        },
      },
    },
  },
} 